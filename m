Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96759790E89
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 23:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbjICVqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbjICVqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 17:46:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51021A5
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 14:46:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383KMNSY006065;
        Sun, 3 Sep 2023 21:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=TfUX5x2DNLsi0eTc/a1ZXc8BiDFqUB0fsnHL2Iu/VIs=;
 b=FPlKpBDbzj7rqBI7AnTcel//DfOgKQIEbKe+HHcWio581IPBx5mknFQS79vzWFs/W0ko
 Ua5l07KTckFuvT0vzyBi5SvhsGzxdbF/Kj4hnRHsP7mMiecdO4Z5KYx7WA5/f4YVBUcS
 0ESRBHyOYJHNAkkrafzZdCNgyZt/740K6uWyViM5ao7eIsgAZMaHVB8Kj9ClxyStIipK
 xX3h3/vowReTgAcqTFxQp+/GxMGkfBQ4rG9jP8TbOj8U3KPag6fh0rvIHl7liSNM9hvL
 Usj/GYi9i3Rl2E6zMTl3h9BGRfluuvyhW18pAARwpnB9JmPVqEbt1rgQlAE3i5pSLjrE Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suw3csxjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Sep 2023 21:45:46 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 383JYAsw016311;
        Sun, 3 Sep 2023 21:45:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug30hbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 03 Sep 2023 21:45:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crVW0Zp3bO2+1dAAxCiuEgN+ZW0+zDKiCsZO++7feftuMOEQwKs7nS9QhX5h9/K1SMUgG6dNKMAS3RrrJu0/e9yMlVqvtfssiKCEbnc7UEOiDi8vsobOXfSEs2nyCt7HG3yR2gSY3H0UOz5KazBoFh6jynaLWKlkcR5ZkPNb7Vw0I+0YPE5khGJ7Ut/mEuByipMfFHIooFwk1s+Jin4odO9edD/CMCuyAleyNEZ5i3xaDQDGAS4v4omgeTNbX+z4iLfc9VUNa6QZFYS6lhh55KmqAlcYCEe7f+nCpr+QJZDMbX/pBqTM10H7kFgjik1lq/RkFfxiS7ekPUr23DkKaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfUX5x2DNLsi0eTc/a1ZXc8BiDFqUB0fsnHL2Iu/VIs=;
 b=WRjLOu4YQEbnZNjZhPkcFiw/SDH5fuaSu8DPefWbHQCZrMhVRszeFwM41Pekmz4D7HxrkwtqzS3p6rfXpTErY02D2BngXE4qzyHeMvFRY4MFqzW8FRigDujkITNx//FS+/SrfqDphPf2yN9CDQI4O9xEuDliOy62J3Fe+s42yqQodu+oK2PWcR/XqFoiLJu6KCUNgFki9GYDiB3wOWDdHGVHAEBupq55bfkgnbEkdiGZPt2kzT3+OrCyNEza8BekXpBn4OXyhPrS7LB9BwU0RJ7Z8oYbesrZIc626yHwOPKnkkRCinhASND0P1L5KgXnxemJem4dovqRDulxtfDXXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfUX5x2DNLsi0eTc/a1ZXc8BiDFqUB0fsnHL2Iu/VIs=;
 b=r62+QgwHjv19q8jvvwhU/jtlZ8pv0BnT7BaBx66aIt+PSavvcY0/xmazJXyTTxhS92JFTEWR/rqQJ5NTUVz3SKpuQyGulfxpsfLv+Hw7X4SEzmSzkHp6x2lK8sxQWJXItEx1dt4aqxnkBz0ATd6VzUAfHQBL1TCvf3KZYxUj7eU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by DS7PR10MB7346.namprd10.prod.outlook.com (2603:10b6:8:eb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Sun, 3 Sep
 2023 21:45:42 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6745.026; Sun, 3 Sep 2023
 21:45:42 +0000
Message-ID: <82009ea8-ad86-4829-b0a7-7dacda762aad@oracle.com>
Date:   Sun, 3 Sep 2023 16:45:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, shaggy@kernel.org,
        liushixin2@huawei.com
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230829165244.460154-1-ghandatmanas@gmail.com>
 <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
 <ae6ce935-96eb-3d40-f252-54fff7eb0ea9@gmail.com>
 <f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com>
 <5dd9b332-49e3-877d-125b-1de5b46af4d5@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <5dd9b332-49e3-877d-125b-1de5b46af4d5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0420.namprd03.prod.outlook.com
 (2603:10b6:610:11b::25) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|DS7PR10MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 6acffbc6-c155-44d9-6bf4-08dbacc71f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2ogqO6SixulE9vl6z0WA9lBfRVlFxdfa9g+FP8rqBDpoQLL7QzqmyhXz43KIdviTebbSkTF+Zfp9T/uQAeSW1Eg8HsePN3Y9acR+mFn81j0G35KUGuI/NtsckWwofe4Jb8ZupmVVid8TEvpcrDS3+lXCfyGJ/Yp3q8MFmaO+f92WkTtrDISBMcO+z1QdaxNEB29DhjLUFWUsE+OXxr2eNLmlGZzQovBvCGyP/jOhL6MskGuan5EmplUa5/nwAO3Xd92fShAGYyHRQv5MVdc2P/5gV68jY4GpNJMZAD/RfEOQ9Dt6/r2GK8L5/GA1gvq4E0CmasXoJp36LS+CM9Qnicd6070yuuKE9n36+NzQxSqMldpNEZ/wJjOJ+jftl9yXBlfFt0P29f++KjgRVIR7UMad0O0eVOdsbbhIuEya3PHvO3NGJ4d4QgGqxkD0U6Uf3IgghzF19P1VbGP912trpspPn71/YbuG5NTij4fcVbTAn+MJcPmaF0WvJ+RCzU+jIX19/nUBSmMadbVA44x778YRDzgBx4S8UXdP1h7QZHQiTb6LHIuIk1k2DpN5gGVFwefOaahngMP0aXXT9dnwCXKhIBcULFvTS94ieSopot+q4BRXE4+aZWjAyPELBtuoynJOCUsn6fXwxbYRlhgug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199024)(186009)(1800799009)(31686004)(26005)(44832011)(8936002)(6666004)(4326008)(8676002)(2616005)(5660300002)(6512007)(53546011)(6486002)(6506007)(41300700001)(478600001)(66946007)(66476007)(66556008)(86362001)(31696002)(316002)(38100700002)(36756003)(2906002)(966005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUpYcWxDTkNPY2xkTGVGd0JrRFpGbyswRHZlNVVqNTFraXRHdXZnU1FIVkoz?=
 =?utf-8?B?VjFiWGtJbnRIelVDbzF1RXlPV090M0ZsL1h2eUdIa1NFTUtKNjc1YndYZUxP?=
 =?utf-8?B?eTVnbGIycEM5V0dRWE1rcXkzcTBFUGNSbE5CcVFzQkZ4ZXhXYkVER3JtOGhl?=
 =?utf-8?B?SE1XVzRrbmpnQWhjNndHVFZETXpTTTdQVWNkSmY5UFVQSmdtUHpQamN0WmNY?=
 =?utf-8?B?NElqWjlZblZreTg1RjB2VmlYanB5N0t6eWpNSEIxbUFBR1NPdHdtMzNOcDQ1?=
 =?utf-8?B?eHZ3eTdNQlFCOG15OWxGRHFFeDZFZ0o4OU4yRFZEQzRhUVpRVVBGMTJZd2Ir?=
 =?utf-8?B?Y3UvK0MxU2tyMUJJNzZnbXN2MlRFV29iZ1FwRVFtNThDL0FHR0R5VDFSM3Jq?=
 =?utf-8?B?Vks2M3ZzWHI1ckJrbVRaVGpGYm5EOXBhd04zaTdBcmF0MkZKOS9SSXZ4WVJT?=
 =?utf-8?B?c2JEWW5MSERLQmZvTHVQR0IvTWNtbWZhNXBPWW9PMkNyV3h5Tm1ZMER5bFg2?=
 =?utf-8?B?b20wbVdkSWYraDVERENRcnIzUGs2VFdmdFNnWjZtTUU0TTF0bHlnNnlPbEhU?=
 =?utf-8?B?Z25ZcEZOanFXMnp6M0dsa2Y2OFQvT1BEMCt6d2k3OUxxRHNOL25TaFZCVzZ6?=
 =?utf-8?B?Y2lOK084cFlGK1B4cUw0S2FaTEdQblM5a05PT2twSkxRRWN1TGtEbXQ3MWV1?=
 =?utf-8?B?NnlJZVVsb3JlOW5WTmZZbk5iYjJaNXNEWmtBY0g3TDJjVFl6M1hJeitqYk42?=
 =?utf-8?B?NW5GZkR4T2lBWHdDMlp6SU5VSlJDOGhuYTRIUytJRDRmSWR5d0hoQTFpdzFv?=
 =?utf-8?B?NWhBNmxjZUVuazQ2Zk5QenpHaUw0QnJTakJzNnQvZ3pzMDE5a0xNL1g3T3po?=
 =?utf-8?B?a0ZGTktySTFXUWM5ejQ5ckRNbEd3TjV4c29FblFyV1V2QzdHT3RMU2JwWVhD?=
 =?utf-8?B?TEt1MHozNUZoNkJqaUZhemZLU2ZaeVFYU1pvR093QXdxbmw5a1RCd0VETnBi?=
 =?utf-8?B?QlM1QUR6M1puTlI5S3laSGxxZDgwRXJVUndhWkoyR3RHOFFLdnBiaUUvV2xk?=
 =?utf-8?B?RU5xQ1g3N0tnMFJWQUFFYzR2Wm1wNkpJMGJJckY4VkFCa0d0dmJ2cU1NNUJj?=
 =?utf-8?B?VDRvVHY3ZXFVbGNORjBZYXBSS3lBYkdsR3NoS1I4MUxTbDlXSDhBZVJxMGpB?=
 =?utf-8?B?czN0K2tZQzd5VjlOUTRkbkhWZE40bkZWNDd1aU1GYzZGTCtjMGF2Vk1sT3d0?=
 =?utf-8?B?SjQ4ZFVzMHcyL0d0Ni9leVdBa05aVXRJbDFYa2NJS2NNYXZlVkJQV2ZXQ1p0?=
 =?utf-8?B?aTIwdGZXdnZrenptRUtPSVNVQ3pMWWVKclN1UU0vc3VWdFE4WE1LWXVrb2JO?=
 =?utf-8?B?V0dBRnpRdEg0SHZLb1BqYmJwbFZiMXd2SmVoSURES0o1Z1hpSmNhWXFza3ZW?=
 =?utf-8?B?YVlNRDA4USsyU1Z1ZVgyd0JPR09MZUYzckxIQkkzcTRBYi9rNlA5U2FTYnkr?=
 =?utf-8?B?TG1HaHFxT2EzVG5SaXM5SCtIbE1zbzlFa1ZqZ01OZHcvMXA1LzVvTWJ2Q2ox?=
 =?utf-8?B?dmNpS3F5TCtraU9CMU5oV1NVVkRyR2wwTXFlMm9tSzg3U0tja24vekxZSlcw?=
 =?utf-8?B?ak8vNG9HNkpybndzRUdpZ0lMQnhQdnU5NUxYVFdjbE9Eb05manJoUVBMdU1W?=
 =?utf-8?B?ejA5MjJyTWRQUnpIOEJHT2dZZ2hHNTQ5QXU5cWk3NEViV25MaHZuZG5YR242?=
 =?utf-8?B?aWJ1bVZpMVV6YkdUV2dsZ3dqWm5lTEV6QTM4UFAwN0lZS2o5ODhYSGNoVFdC?=
 =?utf-8?B?ZUZhWVVPdEV2MzlncmdsNHovTmNBOG5PeEtUUitleG4xUFNPSi9UNEE1SDRT?=
 =?utf-8?B?NnZpNUlEOFNjOThQbDkxTVU0bVA1VWxkdXF1MVh3Ni9nVWsvYlJaeHhXdS9Q?=
 =?utf-8?B?UUZrZkttd2RYWmtIVmFxQU54c0FNWGtENGhrUzZZQUkyV3g1QURmblJtNFlr?=
 =?utf-8?B?bVZiNkcrSzNUSjYzaHhkQzNXUW9EN3Y4UFFwbkdtSWxoRHNSOU14dUUrN0JR?=
 =?utf-8?B?N3hydU9HSDBNSzRjYmM3ZG4yK0NScGZUUlEwaEwrYmNQdEtMOFFuMkRqUU1y?=
 =?utf-8?B?cEZwM29NMDBHeHViOUovQTRQR05VUUlxa3JObm5uOEtiV0R6eW1YdTdBaWtt?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T3h5WG01ek5pRG5Rd0lLT1lOVlBvVTZkcTVWS2k0aFlBbDdabTRqRys1OHJm?=
 =?utf-8?B?SHVLL1FiRWdMV3FvdE54cU9WWnZIc2JCUXkxQXYyeVZKZHl1TFQ5QXJ1Rkpu?=
 =?utf-8?B?VEU1bWw0R3pGZHFrYTUwM3AvRkdZS1NjWlBVQTdzZUxETm45a29zbDhwMEpu?=
 =?utf-8?B?N20wOWhMR1E5NDA0Y0hjS290eGRwaGNTS2pmUVNIZ2JRSmtlc01LWElUVnBw?=
 =?utf-8?B?QVczQmRZNU1uemFIcUtMeURidE5oTVJ3ekt4TEJnaXlJWkxBN0Z0YVlrQzBp?=
 =?utf-8?B?bndGM01qUnVQMWFKTzE4Z0oveUxUZzFFMThSSmk5c2s1dmFwQ2hVa1J2cjZk?=
 =?utf-8?B?VTZqWTlraXFjakVMdkZvQ2h3Z1VUZ0N0eG9MTG5XazVINjhkWVhuaUY3aHIw?=
 =?utf-8?B?ay9VczVJUXd0MVNUOWNCUkRlTzFyTU5QbFlHWmx3VVZMZE9kbjZNemwwcTlm?=
 =?utf-8?B?K1lIZ29qRWRqd0FneE9nZ2JiNDN6aGZIVDhpcTZ4WmtuU0x4YVNIRm5ST0FE?=
 =?utf-8?B?MC8wUmJhTnZaQ3p6YjdmRmlPRVpXSC80MmEvUm5mZGt6ek1YaVFnYjlueEx5?=
 =?utf-8?B?Z0pwUW5QMnRKaFo0S21ORnVpV0xoeGc3cThUWU9Tbyt5cFJSL2ZvK1hNWll5?=
 =?utf-8?B?eFFYNmhJRUNWUlp4TStSVGVqYkJCQmd2Ry9HTk9YdXllUVZGbDU2WjRIb2M5?=
 =?utf-8?B?SGh0SkVObFFicjUzWlRrQzA4ZEZ0M2Z1bWRXMDhlTXhLcW1TcVFQQWZhZFh6?=
 =?utf-8?B?V3I3eHlLZmpyQkZ4Z3NyYUVsYS9BR2dPMGlyN2ZFTVd4Y0MxOWd4QTkvRGd6?=
 =?utf-8?B?VEJHTDMvZzRwMUNES01KNFBrUisrSkt2QTF2OFdqL3ZyLzQzYldkNDc5MDF0?=
 =?utf-8?B?cHdMUVFJVWdyMmY3K2hGMXMvMTNwVWg2OHdMRFZBUWFpMHpQRk11c3pSSXJP?=
 =?utf-8?B?TWVpSko1SkZEWXpsbWFyaFk0OXRqU2hRNWpqK3hPRmpaWjJ4VmF5SDBrR0Fz?=
 =?utf-8?B?bEhNTjFxU1lMRGFkcVFNS2lEV1FMcnlFV1BVM0RlKzhCOHRWQ29hOUhISG14?=
 =?utf-8?B?bGN6UDNOdld4bU1JazFrVHA5dGc3SnNmQUh1cDNDejduUmk2MDIvL09Mdk5C?=
 =?utf-8?B?MUtLQUFVTkV0SkxJS3VYYmRtdUZ0M3hUNllWbWpPZ2VHTkVIQWs0MXlKVGlV?=
 =?utf-8?B?YjFUdTQ5MVJ6aTFoeG1LaGdLOEdrV0lMM0dJYjVzTW5tY3JaUU5iYk43dnhV?=
 =?utf-8?B?cytzb01JQmRMRU5QR1BCZUJGZEVkQjdVdFZsUHR0Ti9qc3Vzd2Z1WFhMbVhs?=
 =?utf-8?B?TUJhMkZrZzZJaU1qNXpCTUxkZnYyMlFZc3BYWWFQRW11azVyOHBaZWxMRFUw?=
 =?utf-8?Q?IabFx9p+mbKR/aVIEUpV/XAnVmWLSo2g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acffbc6-c155-44d9-6bf4-08dbacc71f18
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2023 21:45:42.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JELznN4F6MC2hRUQ99OMg28XE/sbOlX+ZNVccJ3MXRiBriN/0aiSDG8GwE+1gX4ZGHTGUomJ4m+eJ+Uk9ow108I34RAsX0GzStC0JO+EeK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7346
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_19,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 mlxlogscore=909 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309030205
X-Proofpoint-GUID: lMaP8cd0dNPDju2fpv_aF2rxigCcXw27
X-Proofpoint-ORIG-GUID: lMaP8cd0dNPDju2fpv_aF2rxigCcXw27
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/23 12:45PM, Manas Ghandat wrote:
> Actually I was talking about the stree attribute of dmtree which is 
> present in both dmaptree and dmapctl.
> 
> Link : 
> https://elixir.bootlin.com/linux/v6.5.1/source/fs/jfs/jfs_dmap.h#L168
> 
> Since it is an array we can add a check for the size of array like the 
> code below.
> 
> 
> +            if (x + n > (sizeof(tp->dmt_stree)/sizeof(s8)))
> +                 return -ENOSPC;

That will always evaluate to the same thing (the size of stree in 
dmapctl). It would be valid, since that is the larger number, but it 
wouldn't catch all overflows of dmaptree's stree.


> 
> On 01/09/23 22:38, Dave Kleikamp wrote:
>> On 8/31/23 10:19AM, Manas Ghandat wrote:
>>> I was wondering if we could implement a get_tree_size macro wherein 
>>> we could find the tree size so that we can do the comparison. SInce 
>>> the tp->dmt_stree is an array we can get its size and fix the out of 
>>> bounds. Would this thing work?
>>
>> dmtree_t is a union of two nearly identical structures that both 
>> contain an stree. The only real difference in the structures is the 
>> size of the stree, so dbFindLeaf doesn't really know which is being 
>> used by the caller.
>>

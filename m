Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345CF7B74E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 01:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235659AbjJCX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbjJCX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 19:28:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F027B4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 16:28:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393I4Mkm027093;
        Tue, 3 Oct 2023 23:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aXTEbN2JRM3dNYNz1gnC/Zg6nMS25YgzOdlgi3QpaL0=;
 b=YjiRLxjzDC0voJUZ1RWeMxVHVrvTMI4hrDMoQNy9x09BpfyfkXMXCbQkaFwsV1ygwszi
 kyOB6o7vLIAnoaMl5mRlwQ4nzkeJJehGxiGi71N2F4bwy6/QHxugAX3sErVn4aPlfxke
 xrIfl9bnnbzrOXz3wZjWQeWQJfGWZfreEJY1NMmSim5AO/jVaOH0IA3fpA4tctS2bvyK
 F3VaI3zZaMdXgdOajgQUe2heRokyaC8Uak8XhE4MI7hXSNjuNJ4dunAzzK79hOOOJXnc
 o+n3143kb2aumzsfBqfR7egppIUBjoKWx5TWamQhW/mwlqxmtw3OqZOlTiTnPM3D2O4F xQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3teaf45x9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:27:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393MGh1o000409;
        Tue, 3 Oct 2023 23:27:50 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea46psh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 23:27:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3MjN0GvgGN12YTZp2eeUDZpROmJw6IZJlhCUuFx0ivGKqlpIdlZxHOHtuGgv98qNSLdn1dx6WvXhUjeY2+q/zOQ1hh3T0nfL8qGF727g7LsplHTzTI81dzprUC2LsQ7oZrRx7JGJYdYMxzzqbKL30AV4ga+gGc7j1IVPfaoWBSKirGQhIH3h20Etu0kMXaakEkChMumyiz+CARVK8dHsWo3WGAg62Yl7MjNjPrxTWiqJz/CQsbQITcjER44MU4Eh1J4weWQpByrWwrcS3LkFxkSEvizOFVwpDrvsuUom7w291Tkz+Lcu0CtA/cwd9K1ROtrzXh6TAobaxz1cGbhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXTEbN2JRM3dNYNz1gnC/Zg6nMS25YgzOdlgi3QpaL0=;
 b=I8jqpqufrGb0+z9GsAwJLuxBEvP71ZMYT43OrVu/hL56vzsw257z9oOpuI9Rnxj7uU1gaBwe+zNFhpF4hKxE+Pnbum5ed6oUq3xKHEn+B32C/57AfNcjznly5cpqH0MYYREczo1U5sUIrLw7USlyD7eO8VqVLszZrJU69mnymIAT/F17G5HTE5IdyR77S9atGNhvK+LWJqQ/lzFpgFnnBYPR8mP9P+7dSdBJZUKWyOb7N1LqxTE9xFTYjGJFE6rXuherYUB7fVXIoZQHwaiQFaNMCiGWfSl/eW6KYiYeU3c9QfOshG2jeOq2GRXcl9jkeET1OKs3EchVbaUPn07dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXTEbN2JRM3dNYNz1gnC/Zg6nMS25YgzOdlgi3QpaL0=;
 b=VL3kzbbkYjQK/jEXf7YqtwpswdGYuefBw5r8I6EtbwmXnu12ZZmIQoPfMHsrG8eqNGVv5/hM1Tfod2Mf/E20oLwnhArmMKVNREc7wob27mR83u8napMYnCH5g24EvXjyDHDTJPQ3kZGxMhznFODa6N2MaHlPaTRKZMyhx+iM91E=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Tue, 3 Oct
 2023 23:27:47 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6792.024; Tue, 3 Oct 2023
 23:27:47 +0000
Message-ID: <c943f428-3759-4922-9622-fd481d0ac26d@oracle.com>
Date:   Tue, 3 Oct 2023 18:27:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs/jfs: Add check for negative db_l2nbperpage
Content-Language: en-US
To:     Juntong Deng <juntong.deng@outlook.com>, shaggy@kernel.org,
        wonguk.lee1023@gmail.com, liushixin2@huawei.com,
        andrew.kanner@gmail.com, wuhoipok@gmail.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
References: <VI1P193MB0752E63048A98BC70E4CFA9E99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <VI1P193MB0752E63048A98BC70E4CFA9E99C5A@VI1P193MB0752.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:610:5b::20) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 30aa0038-bafd-4203-f304-08dbc4685a45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGxuNEhyYThlVzhmbm9XNWJYN1VJWFFoZU16Z1h3cDlKRjQxWGM3OW9ONjhj?=
 =?utf-8?B?NjRFdmNBWFN5bDdVTjNVTzRyZlhmbHpwY1VMakxzNFJwV1JGN0FVVUZkcFEx?=
 =?utf-8?B?cUo2d2o5WWl1U1E5S0g0eFR1d0xib200cXZnRjFGclFvd0hIT01HMXJHcXVk?=
 =?utf-8?B?ZkRkNUw4Y0MxMUZGdTQraGl3MlRsSjcwdXZBMVpnN3FwdW5rNkR3V3VCc3R2?=
 =?utf-8?B?amk5Qzd1eEFUUDJVWmZtd1hqRUNlUHJjSkxLUCsxL1pTNVJjVXBKTDBlM1dj?=
 =?utf-8?B?d05YS2REOVFnRGxMMkRwR3JZRmF4S1ZaQUlncVcvTCs0ek1yUktSRlk5dVFV?=
 =?utf-8?B?QWdIbmIzTVB4ZHF2elN2QWhLOXdId2FQVDdWUGd4RWdsbEVabmFDU01vZEM3?=
 =?utf-8?B?SXMxYTFReHN5UXJWc3NBVldjdVBLRG90bFczQUhsSVd0NWhiNXRQZGdlR0di?=
 =?utf-8?B?V2NTK0JWQXhsSkVOa3c4UUx1MVh5U0xlWmt4bWpBM3Y2SHFJREhTWHk4WnYx?=
 =?utf-8?B?QmJ2OWd2anpVemhOeVR0RG55SUJOZkNGWGsxQ2NQc0phY2tsaHdHbGpqbDJ1?=
 =?utf-8?B?RG5KVWw0YVVmZmI3K2xvYWZlY3E5d05Ib24yUTJnRDFMNkxIY2ZvRXdYUFk3?=
 =?utf-8?B?M2FHMy8yQkVienNYTStSV2NFNS8rRVFiMkQ0bzNaZGI2aURMRlVQSWhNRFlh?=
 =?utf-8?B?TWd5RjhqdlVxd0J6ZkdlWWx2akNQQ2ZuNjNkamRUdjlqck5yNkVJNGFBN20w?=
 =?utf-8?B?RnhTdnpSUWlJczZ4YloxYXpnMmpHbUpRMmJqbkdMM1dwb1FvZ3hLSXNNUXNn?=
 =?utf-8?B?ZEZ0WG9NSmMrd0NudkpRMk1TUlRLSE82K09zbkxlZHpKcnc2ekhQM1NTeVdj?=
 =?utf-8?B?WHFWeTZBUkpVUEtaTDBrdEZab3BFZDd6YXZvNUN1THN2TlBUZyswbCtFQysv?=
 =?utf-8?B?ZGdMNERhVUFxYnNaUHRIZHVtN3NpZnNZeVRIeEVtZTBMeGtxNXdoNnFqQXlp?=
 =?utf-8?B?cmZiendLeWFJeWFBUEZiaTJXZEN4UjdoWnFKS3YxQmloL0F6ZlNGNlBJQ0Nr?=
 =?utf-8?B?YUZ6aFlyQzgwdTJQSWNXb0QzQkMrNll4ZFczSmNBWFNyTWtMdlVvMXQ4QzVl?=
 =?utf-8?B?cXVoUWhSUDVwdGRxcXdWTEw2cGplTnJWWTlJWURhaVZncmYwczF3Y1ZzU01U?=
 =?utf-8?B?TTl3b3lhQnEydUxFSzB3MEY2QlMybHVqck5sVHBFbDV0bC9tU3JHSFdGZnVr?=
 =?utf-8?B?cVFBV0syMVlXZGdISGdKSWZaOEVZeFF3RlZub1grbjRLbGRCY0xROUJVOVpI?=
 =?utf-8?Q?1JuRMJkprRBkQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66556008)(86362001)(38100700002)(316002)(66946007)(2906002)(478600001)(66476007)(966005)(7416002)(4326008)(5660300002)(44832011)(83380400001)(2616005)(31696002)(6486002)(6506007)(41300700001)(6512007)(45080400002)(26005)(8676002)(8936002)(36756003)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBkMjRoUDRPVW8yQVFTZzRxZWMvcVhNcnZnQ0IrR0F2TVZqdUw2NXFiV0ky?=
 =?utf-8?B?aDB4d3FGc29TaHFIZGFVSW1yb0F0ME5OQ1czQzAyYm9kcWJ1T1JEU0l3UzJC?=
 =?utf-8?B?NkcrNUEwTFA1MTN1RkkwY2xoNkh3aDhGZ3lRUlZjY09IRXVnRXkrRG9FamM5?=
 =?utf-8?B?ejBoTDZTeURZMElEL045Yll0S1RaeVczSkRtbVpncnNPTFY1aWdmR0FsNUxZ?=
 =?utf-8?B?Z0MxaVNscVY3dHF4WDNFRElHS2VyQStBUWdiMnR4cTBYZlNla2tTTTg0RGFP?=
 =?utf-8?B?aGpOWG1yUm1wRmdRWUF2aEd1R2s2TXNZcW1WRGk3T2ZyTVE0VitoTUhmekJJ?=
 =?utf-8?B?WjdiQ3NURk1KVHR6dUhFQ0R6dTdCSWRUcVNHR1EvS1JFdVk4dGNNZmxDZ3hj?=
 =?utf-8?B?Uzd0clFtQXdiamhjMWpRenBPdmp1dkY5cWJORS9qTHFkNHpONEM4bHNsRmpl?=
 =?utf-8?B?NFFDTVdOdXJkVUN4VUM0ODZwTFhpMEs4UHVabEF6VFpVcHBzRUFGOWwwbytk?=
 =?utf-8?B?TUdvRElmbTJxdjFITDFPS3dUWjJidTFKWFRUY1NaUUxKNklXTFROWDlzVk5M?=
 =?utf-8?B?cVhCME5MOEN3SjFsWGNjSnNXY2VlNE5ISENVaUZFYThzcmJsS3dPMEpHMkx0?=
 =?utf-8?B?bG5RYnRDV0xiajNNSzFPb0hMUFM1Z3FURjVvaUpoNW4xc01XdnUrTGsybDNY?=
 =?utf-8?B?ZVZKTFVKNDFjSUx4WmNES2dNRGliV3Q3ZHBtOU9zWWVTSW53QWlGVTY5ckha?=
 =?utf-8?B?QW1QTTNqbHRKeVB2YU9YdHZxV3ZRdW80ekxXeHpZQWc5MDFtWi9lTGZyUFd6?=
 =?utf-8?B?NWNyTjZ5a2ZTV0VoZkl3S3pnZm8zZktiSVo1VHNYcTBmc1ZnMWdDYTFkaVd2?=
 =?utf-8?B?d0xreHg1eXovZ0hNdW45d0xVL2FVQVhiUzVaaUd2azkva2xLZTI0R2ZXNHR4?=
 =?utf-8?B?ekdLTk4xN0I2c3BlcE4xNXViZFRRdEEzU3BBbnhWUHFzQmsra2M5bXQyeEJB?=
 =?utf-8?B?ZnB1MnJlK0l1T1YycWRxWnJVcmU4WE5CdmJoUEoySjhvRGtVK21Ob0E1M1Nm?=
 =?utf-8?B?K3E3WkpoWkkxUm82YXg2akxsR3ZWRkt4V2dpQWtTMThnd0FucU9JdDNQZUMr?=
 =?utf-8?B?WjF5bXVwMGJzem9ncVFPREgyYmdnR1hPWmZYejRXL1NBM2dIR3B6emg3QXpJ?=
 =?utf-8?B?a3VxTndzZ2VtMHFaSUkwLzZXaFNjWU05R0JWY3Roc0tBMGt5UUdBZFVzbTBH?=
 =?utf-8?B?SlZnbityTWVjb3AyZGFVcXdiRHZrMG1mc3ZMMkZ6bTFFTHU1SlRsT0J3T0ox?=
 =?utf-8?B?Zmk4aEllVnRBWDF6OTQzN3pzVnJRN0VML01vOWhiY0NHWHdLVUtiOHlBMHFF?=
 =?utf-8?B?WmJERVVGSGtOb0lOemo3MXhxUGE3cHpmandTOFBvMloxVUVZUmdZS1IzTkFs?=
 =?utf-8?B?Y1B2dnlsUFlzTkV2U083YnNUS3NsbmZIa25zMWxRTU5CbEhyUEh3N3d3M3kv?=
 =?utf-8?B?UjNNMnVpajA4S3hlbFpxdnVYTVl2cnhaNlJOMjRRK3lpSkJBVjVYYWJ2V21J?=
 =?utf-8?B?WVZSWTlQRE15aHJma1Eyayt4YmRBcXNubDNpVUwxOFNmZE5tcUkyMWtGSGx0?=
 =?utf-8?B?MVRVempLZ0lRNGdLRFNpQTNXbnNBNVgwRkdUSWJDdzVoZ1NVdmRLV3BEb0lj?=
 =?utf-8?B?c09EQ0NCMkh5OGtqUVcwUURrTkdOd2ZJaDBGQkRmNG1vYzFXSlRUM1g4WWRt?=
 =?utf-8?B?dDlWTE1oMlcyYW04cUlYT3Q4a1RVL3p2NGdGcko1VUE5b3prRXpibjE0Rmhv?=
 =?utf-8?B?RGZFSFZCVmxSMHBoc08zN2tjai9vc2xERXZjWmEzeks5d1FoVDdYSllzMktQ?=
 =?utf-8?B?ZXE1YklDeEY5V3FNeTJLN292NjRSYmhxSFJOMFpBMVJXbndVVE1Xb291YXV4?=
 =?utf-8?B?OHZVeXJ6U2FpNkp6VGF5Q3pETHEzWjYwdHU5MXd3TWVJSWEyVnFqZS9pNVds?=
 =?utf-8?B?bkxtdFYya25DYktCWDNDK0lwZWE2UWQzV1FnZW9NOE12ZmMyZTNQV2JPTXk3?=
 =?utf-8?B?V3N4OWZuTTJMclFJVkhvSlhqNnVpRHRrWndiZmRHb2ZBc0szQzFqZ05sTWxB?=
 =?utf-8?B?bVRBYnV5T2p1SDBxWUdNSjR1NURnQ29ralh0ZTdPVW9MMkEyKzZaTGlSUURl?=
 =?utf-8?B?V0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NFdoYTFsb2xSam5pTlpYMmFwejBGV1FXNjBZSVdxeWU1alMvcERHVzJtWExo?=
 =?utf-8?B?U2paY042bHJpNVE2cC8xR2dUYlJ5UmVrbDY3c0ZxVXV3TWhSeDkvVnNxOVNC?=
 =?utf-8?B?V3E0Y1huWjZ1d1ZQcjhkMzZsMXJVTGJIMFZLU0tXNlpKeHBMNEhpVkZpRGh2?=
 =?utf-8?B?dnRXNVFnKytubDNIT3JNeHBocjVaN2dmaitNeGtiV1JneGdqTnhsVVc4RjIy?=
 =?utf-8?B?cTJ5WStCTW9KU3I2d09yUTFINXh1OUJqdWNIN2VUQmZqTTJIYjIyamEvcTJy?=
 =?utf-8?B?cXh5MGJ2ZkFpNHFZdXhzMlJhSEVibDFzUnhwMTd3d2I0ODgvcTIyRFREY2oy?=
 =?utf-8?B?OC9iam1FZVc3OU9Xai84R09zc0pBODhFcUtlcmRWMGdTcjAreksyckR6OEhT?=
 =?utf-8?B?NUZUUnMvZCs3cWJWajZsZXR4ZDdCakVTYkVMeHdZb3VVeU5PWGxBMENDUjkr?=
 =?utf-8?B?czJ6K0pSZzBWSUdMdCt5TElENGdZL2JpT0NOVWNzVThtY3BBSWh2NjU5aGFi?=
 =?utf-8?B?MCtRNDRONHEydzFNdU1DeUpoVHgzZm9QQ0FpWEdPeEExa3hzNW43ZWhyZys0?=
 =?utf-8?B?MEFnMTB2QTQ2cS9yM0RNd1RaaFBZTEFpSlJVbWZwTjJUQzNGZ0IrdzBsT0V5?=
 =?utf-8?B?bGY0aE8vbWxEb1hxZnAxYzBRQk5GTElRZTBYZlVTZWdsUXcyRm9zY3NraXE1?=
 =?utf-8?B?a3BtVlFDNEhGT2l5NllFZDd5N1JEeEI5UGdFazh3ckVHTUtkaGNMVHZSRVE4?=
 =?utf-8?B?SFI3M2ludmFYVlptYWV4ZHFyN0grblBBeHI5Mi9wd3VHelFpa3BWTXlvZ3Fk?=
 =?utf-8?B?MnJYanlrbVBZejBPWDBjTm0ydngxKzIzSHB6VHF1MXBpQkJWNitQWmFTeFZX?=
 =?utf-8?B?UHk4SVUrSk56RjFKQy9FaWh4YWhVdC9wUzJBblRDdFY4K1U5d3lOZ3k0T3cy?=
 =?utf-8?B?Nk1vT1l4VEtzem1UQVdtc0d6WWs5cTd6cXgyNGp4bnAxOTJUVE5YUzhqQ283?=
 =?utf-8?B?cTJjejdPQXJzaXlRTThERVVsdFFGTmdocVptWU5iZjdNc1ZSaGFZSTVqNWpm?=
 =?utf-8?B?T1BIdnhxVjZkNWNHTWtuQXFBR2x4YW0yRFZ3Mk5KM0dwazlNM0hZenN2bVVl?=
 =?utf-8?B?YnhKM28xa1FJbG1weW85REE3NFduWWcydjJIS2RSSTZ6T2lGSGVXM0RYUUVt?=
 =?utf-8?B?MDF2Z25BNGxOYXhrK055T2V2czBqa0t0aVpKem8xcmpXWmpuTmVUdjR0d25z?=
 =?utf-8?B?d243T2ZyaSsxRzFLSFpQOXJOSFlDR1lvclRnUTlRMndoSm1ZWDByZXNHMng3?=
 =?utf-8?B?bE9qMkcwcktJMUNvQUd1bTFONzFWR0QxRWl4UTJGV3pYbzhZTTQ5Wm5TZXJq?=
 =?utf-8?B?eTZzRnh6QWVjbFEwWktXaGt6T1J1cEtvWEl4V3ZYcG1rQWZnWHozNGorejdV?=
 =?utf-8?B?RWpHWHdMcnkrZWFyV3BMRnBueGtRNVRBYWFyUlh3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30aa0038-bafd-4203-f304-08dbc4685a45
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 23:27:47.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WTQ5k1qQdF+y+T6KuWN6/gBMHH8eC7UJjyhCwFWAom4xoyphMkHAbIjLfREnkBCuUXEwpKLYNNN6KmmWG1G9AQ/AGnsYCAhyUx5lbz1J9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=870 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030178
X-Proofpoint-GUID: nwT1frCOkzPADS2215ZrynbEUogwyomC
X-Proofpoint-ORIG-GUID: nwT1frCOkzPADS2215ZrynbEUogwyomC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 4:56AM, Juntong Deng wrote:
> l2nbperpage is log2(number of blks per page), and the minimum legal
> value should be 0, not negative.
> 
> In the case of l2nbperpage being negative, an error will occur
> when subsequently used as shift exponent.
> 
> Syzbot reported this bug:
> 
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:799:12
> shift exponent -16777216 is negative

Looks good. (A little part of me wants to go through the code and make a 
lot of signed ints unsigned, but not today.)

Applied to jfs-next

Thanks,
Shaggy

> 
> Reported-by: syzbot+debee9ab7ae2b34b0307@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=debee9ab7ae2b34b0307
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>   fs/jfs/jfs_dmap.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 88afd108c2dd..3a1842348112 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -180,7 +180,8 @@ int dbMount(struct inode *ipbmap)
>   	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
>   
>   	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
> -	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE) {
> +	if (bmp->db_l2nbperpage > L2PSIZE - L2MINBLOCKSIZE ||
> +		bmp->db_l2nbperpage < 0) {
>   		err = -EINVAL;
>   		goto err_release_metapage;
>   	}

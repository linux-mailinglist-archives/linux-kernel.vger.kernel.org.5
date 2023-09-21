Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48837AA5D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 01:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjIUXwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 19:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjIUXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 19:52:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3C38F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 16:52:03 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LIsMRm011445;
        Thu, 21 Sep 2023 23:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=3NTDq9SsPUCKFF3ukfEeeA/wahGH/+7A/voteWagN78=;
 b=RIZx4GpJotNixm5xMLqqohJablg06KkpwEiBLfF6EF+k693DKiDtMAI2KXU7tV73+9Oo
 8naGEi8X3yxdyNJoUcM78H5WskwCEE05kZtdLy5YEWnGRPv/Oh8/D1vZnGRYMUVT5Zg2
 PU1g/cITfviL4H5QyuKCQTD0FyvsGzBFADN/464MkcwbkwCj5cVscTGIoqZabawcWXM1
 Eyw28ZusyroJkCzo5AMiqkBonEjhY7tIIGznOME9g028DZ4Pitf0hlnzsJtdfDxxVXM6
 /uOU7JiZsnOEaiEF7zTeDjQEmXibGnlcO/E/f1qac+BJyy/LvyYbsH4kU9dQlXgFqHdS BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t8tsvrh7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:51:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38LNY7EA029956;
        Thu, 21 Sep 2023 23:51:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t8uhc0qm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 23:51:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JsI8vMHn9NQ5fEhnBReFYmE0hVWJqSbq3C8fpOawvhlJO21+VZVlLir6R/zas4uMZb4dmuSIDsPoBZUjzSb7PoMkJXAjy019e82gyIRmGMEDNM2gXoFyKjetd+qyLCQ6QsctJuHT0flPNGzTpOhb0KeEq6B/kY7sACZSCMGmBDIcPRWX+oGt7V8eGHZb6SbWSQvbYZD1xirRyMQmI8MkTC9OI08Tsgd9wLVENjZ6ds+Uoje71zho3R7v2zjsn7ylVsaO6teeY72UavGlyHhMt0Be9lqGlSwj52fARmbCAh1OqpApoKffflR46K/+OV+qCiMG/aEHAegYhxQjzWsiVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NTDq9SsPUCKFF3ukfEeeA/wahGH/+7A/voteWagN78=;
 b=EAzv6hRnH7KqFGAc7LKBSObcFtZhY5J0PEwYAmgYNh0y66tx8HSZ09gKC/SQ6CNJ+TgdgwGEUN8wgODXZYrAFQJ1y24z1eEMpoCH1DHJAUlSWt4hvP+XnlXZSFa0p2jTx+RNrqjL1YhskDrol7O81B63BFqOK0Xl/4gvNQMfF4VI682vwF620cgeTryd55fbR5NYLprcGD1IA+DwPNu5l040MbSyQtrSqN4GeWPhrORqXMrV9JONB7Z7g2fgOuuw3Rq4tfxiO35dKb43I2nj92UzNGCAHw/WUuF/d3upzKPrRxzOqeiqN5B+GohMIp7G1eTnPO9MPxPSTwoVyxKehA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NTDq9SsPUCKFF3ukfEeeA/wahGH/+7A/voteWagN78=;
 b=oYzYp56/EPPLE5HBnbmisLYpHLjKGU9t3IhtX680uTRZJoYIDCOT5HhodaFOkvY9S4jCe8QoJlXWoSyXtl/huYVzbqvDAyOBDH+Z4N4m7o+5IXlR51+RnVUuxPY01bkhPHfWw6V5pD9V5DtyhWWUZxvEDokC1c9akNs1fgpXNkU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6369.namprd10.prod.outlook.com (2603:10b6:303:1ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Thu, 21 Sep
 2023 23:51:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 23:51:43 +0000
Date:   Thu, 21 Sep 2023 19:51:40 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH 0/2] maple_tree: Fix mas_prev() state regression.
Message-ID: <20230921235140.f5wapuwbjcfzwjuy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable <stable@kernel.org>
References: <20230921181236.509072-1-Liam.Howlett@oracle.com>
 <20230921112521.fc07c658804f4e188179da77@linux-foundation.org>
 <20230921185330.j5jw3oms4tc6crkf@revolver>
 <ZQyYH+5pnDc1KYj0@casper.infradead.org>
 <20230921162748.a85eb5af766e0662e4f22a5e@linux-foundation.org>
 <20230921233422.kv46hm4lddhp6rgb@revolver>
 <CAKbZUD3GS7YJmeO1q=f7LRomkJAigQaFw93Vwn99jZaO9O1Eyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKbZUD3GS7YJmeO1q=f7LRomkJAigQaFw93Vwn99jZaO9O1Eyg@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0277.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6369:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cbe955-6378-44ce-8ae7-08dbbafdb520
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I31YjYH4siAGDAo2L6oPa7//Cm/1TKeEZoNFoYOwU1ME5U+kR1iNeoNWg79Pwzxe9K84VQTEYrk7dd+n4yGXrfMBO2NcyK7fIpiC4SJouCucVuovRai/G1/NXyB5frTkdjup6QHHQkTlhjOpAVsB7QYaHA3OD4SCzFEVj0CrPjb7wGWSaO5ZyrvzBth0NsGzpM0F3Jr3F6rMJ4vtKoYcY291fAKQnp7KUXD2bWp27N3DoE2BZgvFgPJ8i+W7CaJDnD9Oh8TkHQVT4lUI2OEFMtaBx1NR5+NMYJ65N2SFfSuS9rYIsL9w8W0UVnIrPQKnQAOkZv/rnzbjp0KLe+6TarchW4O4thNOabzjAXqbm/BO0+ZsM4CT12zQag3xajTMZA1OOCBuZG3h9JM45+23yxZk/98No2XT5mlh9X8nQ4QlyZZvcFT2cns33mWwlpWUClMO13fcrH81tPBYmSGvl43CQCpH95hUt2uoNd6cvF8Gi7PVKgEdsW3T+C/m+1+r8XpPMtX5eipzZ+JyQn+pVEgeIWTjNQ4LXt6t0uYGCYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(346002)(376002)(366004)(136003)(1800799009)(186009)(451199024)(9686003)(53546011)(966005)(6486002)(6506007)(86362001)(38100700002)(1076003)(26005)(83380400001)(6512007)(6916009)(2906002)(478600001)(4326008)(8676002)(8936002)(33716001)(316002)(41300700001)(5660300002)(66556008)(54906003)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2ZYRGkwejJiMlhGNUJicHZMYjJmUkFNQ05WZ3NTUUhDOTBSa1JlMUpPWit5?=
 =?utf-8?B?blJKWGViVkt4RTM3NHd3a3NZMldCdndBZ3gwV2pkZ0dlQVFJU2FvTUJ0U3hF?=
 =?utf-8?B?dlZGa3MxODhsMFI3YlloYS8vUXpJWXU5Y09kNnVHcVpQVUo0ck1RKzZiM3B0?=
 =?utf-8?B?WFFVMVd6aXVPc0tsRGViUCtZSExia2NrenpMeUY1TGlCcUlJWHkwYlpEYktU?=
 =?utf-8?B?ZDBuU1B1RFYwdjVVeHIxVDQwenBGODg2RmQrVkZhL1NuUXI0dC9IMVdCN1F2?=
 =?utf-8?B?STBodURqVm13NDVwV0RjV0ljNzVNK0tpM1RKQ3lGOXNhYkw3Yy9zMTJwRUhU?=
 =?utf-8?B?YjMrZXc0RCtGcVlkNEFVK2lFNm9NSDd1THMxeWhiWVBIZ1c4ZHQ3enpSUnQw?=
 =?utf-8?B?OXlhVFB6S3lTaFJzL1o0WlNHRkpLZ0k0Q1hMQ1d1OWY3akpVVUgza2UwZ2hJ?=
 =?utf-8?B?RXdQWkdNZGExOUJMUjhJb3Y5T1F1L2VncEpvV1NobERZdm1Dc1lhYzQrSHVo?=
 =?utf-8?B?RklWeHpRVDBLeG52cmR5YWhLN3VzbDVnZTJmR2E4U2VmSGxhMzBLVHUrc2F2?=
 =?utf-8?B?NGhaNDAwem04QTRLVjVGWm8ybkVKTE5sRGFtcGhiSmdHajFKallxcnRIdVpq?=
 =?utf-8?B?emMwYlQ0YlVEQmZRSFN4N21Rc0F6a3RVRG9kYzlINW82N2l4a29lbGFWQWs1?=
 =?utf-8?B?MUF1aC9mRks5dkNMSUMrOWxoVmRjdmdtaWlkSmZUbTZ1bmM4OGkwcm9rUXBM?=
 =?utf-8?B?N1pHNjZCcmdxbjFwbWRENXdhTnFBN2owL0JzMy90dWJiek9TbVZEV205ODRh?=
 =?utf-8?B?cTVTWDY2cW9FRFdqOWROT01qQzVvbDVHOXYzbEFjTXE1Qzhra1NjNFVidTVG?=
 =?utf-8?B?NmZ3WDhod2U1RitiUXVWZ2tUUGt2MHFDRlc1OUZKa21US0lEQUhpU2JYSXM4?=
 =?utf-8?B?VVo2WGlzOXNhdG1SK1h0eUQxTFU3ZDJOK3ltUXZYQjlYWndsZjA3eUU4N241?=
 =?utf-8?B?ekwycVlHS25ZczFPMlhiU2x0Yk4yQUtXUHBQcUI1dDN1dzhFdzQzc3ZVMUVx?=
 =?utf-8?B?TE1GYitVendzUFlLYkc3a3ZmT2ZDcHhQRWNBTU05U2UvR2hKbDJWM3VHOUdB?=
 =?utf-8?B?dUQ4SFh0bXNzOTAyYjFXZXVpSDBUekx2V2d2aGEyMG9XOFMwSGQ2RThEN2U1?=
 =?utf-8?B?Q253cnI1aUJHWXUyZG42SnpSMC8rZlpJQmdORDVCTW42ZjU2TkdJQUNzd0pQ?=
 =?utf-8?B?dW9nNU1YL2padUpCZElnOEloWUtkVHdUdlJTMlJwd1dvY21IVzZJdzdtaWxn?=
 =?utf-8?B?OHA4elJ5dExyTjBGQU9Lc3pXa240OGorZThsaDhsWk9XTUN4Unk3V1JoNWpC?=
 =?utf-8?B?TjNpMWYvWFU5WEo2clNmZnRGbUVnSTRKNmpLS3JnWVl0QldXcWV2TE9hN0tT?=
 =?utf-8?B?cXZYcSt5RmFHbi91ZjN6cTNhNXRMSTlva3J2L2lTclhac1dlUnVCTWVQUDFC?=
 =?utf-8?B?RHRFYWliYlI4L254Q1E0MFR1ODNUQVBGSWhKb3pDODUrT2ppa1BvU3Npa2Zj?=
 =?utf-8?B?RGNMNXZKUG96eHlOdkFRVlNYN1pjTzV5bGUxRU8zRDNwMGtpckpGVjBrVnBk?=
 =?utf-8?B?cE1IQ21CSTJLVjFiS2c0NVRyNlhvZVFoWUZGL3BmbHRmL2RTRGxNSGxpenNR?=
 =?utf-8?B?YzlGcnVZUXpxVVB0K2xyc0lVazNONmhiZmZXZ1VYd3EwckR0SHRGZUxnMWFu?=
 =?utf-8?B?K3gzNDVvU0JoajF1bUhXTHlYK2RsTjhlekZnemkyZCtmcnlRL1JHUERzL0hk?=
 =?utf-8?B?Vmp3UkpyV1NBUmlUbXlrRTVRdHhwT3dkMWhSZDlzUzNQSVpvNFJNL3Uzbkxv?=
 =?utf-8?B?Skl5NnZDbmt1cGJjWHhERGV2Q0krQ2l5TEYrdExZYnhDZWp4Q2xuRCtjcjhE?=
 =?utf-8?B?NHlGbGYwTHRiSVRBSVoxRnAvNGx6RzlQdmVaSkU0Z0hwM1RHbUZyWm9ld0dC?=
 =?utf-8?B?dzRDeTFqL2lIMUdxSGwwQlo1VC9ZZ0pRN3JVWlBxd0NiK0ZUbUJIWVYzN2p2?=
 =?utf-8?B?bWJIcmJzdVJhemdDUnVMc2xoRXBNVDhBWXF3MU5YNVIrNjhxUzhKUWladXI2?=
 =?utf-8?B?VjRuZ245WHFYa0NSUjE2MjNSY09SMXk1TlRLTm94MWtNR2dMV0xBL2Z0N25N?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmtseGl6WFFUa1RmR1Z2M1A0eXBDU01VZXE3M3J2K1JYRGdYVGxFVC9PV2Zh?=
 =?utf-8?B?ZVFUNU13UE4vWEhld1lOM3JuWHJnLytYZ1N0VlVjNHZUS29JYjNGbjl5MFZD?=
 =?utf-8?B?QWZVWWYzc3VQeUtIMGhNSklqN0txblMvdEZxT3FkV0w3ejM2TEN0SUdKbGVT?=
 =?utf-8?B?ZDkwbmRGbzVJNkNxSDVocFNCa1RUNzQyUEE4MWN3bHNlczYzZlUzNVZuUzd5?=
 =?utf-8?B?WmhraFdOekVGVWxLNXlieXVRWWxQNXE2NTNMbGtNU0h4YTZVN3puMjM1dnZU?=
 =?utf-8?B?SVlkMmJFRi9VeTN3M2JQc2oyNWpjTVY2bUNGQnRDbXRqUlBWTnN1S3dINmFz?=
 =?utf-8?B?aEFaRHM2ZHArc0hScWt6T2lBSmxmd1E1RWQ3Q3B4amUvRkNRNHhQSHYzK3JQ?=
 =?utf-8?B?WEl1b2d2N2NLdmxNREo2OHA0UE5yVEVzUnlneVVYUzMrUlZBa0ZYdEN6S3RR?=
 =?utf-8?B?YkdzNDFDemt4dWMyVzluMFh5bkpyb3dYaCs4cHZZZTVkSS9OblhlQjk3Kzd1?=
 =?utf-8?B?UkZmZE5wOFZ6anR1SmRQQnJNeVR0VWZHSUhEQXpkTXBrbmtuVzZ2MU12Q0RM?=
 =?utf-8?B?R2pSS29kT0xCVzAzUEc2VHk2cXV1RzJPVmlJM0ZwUXFETmdSbktDcEg5VFBH?=
 =?utf-8?B?YmZobXJSUyt5RG1FN1k3UjYzL3ZzWVRoRUhCUjZQNzlBdVFGWWVoN3lzM3J2?=
 =?utf-8?B?RUhTQ2xUeG84TlJvUzhjRnFtOHlTYW9ydmwwa1hwaHM2MFZyUkxUWjR0bnY1?=
 =?utf-8?B?L05rUjA5b2lYM3Y1K21oQmpSWkRwbmwyc254Z1lYTit3Y2xJbU9MU2pUZlk1?=
 =?utf-8?B?NXcreGVRMHpIeno3ak9tSS9rK1J5cG9KNXFDa1F4MnZVR1BrcldHS2wvcmR2?=
 =?utf-8?B?enFza2MyOUEvRlk1M25GcHlWNm9YbDhoODFkdWZUZmVFLzRjZi9XN1hiMlRI?=
 =?utf-8?B?SmJxNEpiWTgxbnFtcGVCbCtnK2pFL1E4ZFlkZnU3OUZBWnYvSFVZbUJLQmFv?=
 =?utf-8?B?N2J2UHM3eFZqcHBCSk5XWWVLbWpJK3E4WTRYeHg1TWZDY3RuV1ZtYVRIYzJL?=
 =?utf-8?B?bGlWTnU0MjdNczF2NEJnY0svelN5YlUwZjB4NGpQZkpUaU5WUGdOVUE2RHBR?=
 =?utf-8?B?RHZNbXdGLzFMSkRkNnNBblBHWE02Q3l6ME5nV0FRdVRidEFSN3ZZbGdLRFJ5?=
 =?utf-8?B?OGpVQmJXdzFoUlNVSVc2M09OUktSdS81TXkwVFVQNDdoRm9oejQ1Zml5alpj?=
 =?utf-8?B?TktQT09vdkdnci9kVlp0L0pGd09oU2ROZDFFa3RkRDhJOUtrQVVIOHVCTFpS?=
 =?utf-8?Q?Fvf9Er/TuJwC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cbe955-6378-44ce-8ae7-08dbbafdb520
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 23:51:43.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hnvc/A3g0FSRBqxESekxy9dzsdilGiHf5QsKKdIa5EdfFVaOO1g4A9OngL6wrsnJlkIjQ1LMqTd+hbrh5lheRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_20,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309210207
X-Proofpoint-GUID: lbDexur3vFjcrf0eBjkw5lueQ1WLH9o1
X-Proofpoint-ORIG-GUID: lbDexur3vFjcrf0eBjkw5lueQ1WLH9o1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Pedro Falcato <pedro.falcato@gmail.com> [230921 19:41]:
> On Fri, Sep 22, 2023 at 12:34=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Andrew Morton <akpm@linux-foundation.org> [230921 19:27]:
> > > On Thu, 21 Sep 2023 20:23:11 +0100 Matthew Wilcox <willy@infradead.or=
g> wrote:
> > >
> > > > > > It isn't clear what are the user-visible effects of this flaw? =
 Please
> > > > > > send this along and I'll paste it in.
> > > > >
> > > > >
> > > > > User may notice that mas_prev() or mas_next() calls that result i=
n going
> > > > > outside of the limit passed to the call will cause incorrect retu=
rns on
> > > > > subsequent calls using that maple state, such as mas_find() skipp=
ing an
> > > > > entry.
> > > >
> > > > When Andrew says "User visible" he means "userspace visible".  Not
> > > > "in kernel user visible".  What are the _consequences_.
> > >
> > > Thanks ;)
> > >
> > > We have a Link:
> > > (https://gist.github.com/heatd/85d2971fae1501b55b6ea401fbbe485b) but =
it
> > > takes us to the reproducer code.  If it took us to Pedro's initial bu=
g
> > > report then the sun would shine and birds would sing.
> > >
> >
> > I don't think the irc channel is logged so I'll respin with a cleaner
> > changelog for both patches and the subject of patch 1.
>=20
> FYI:
>=20
> The original distro bug report: https://bugs.archlinux.org/task/79656
> The original userspace program bug report:
> https://github.com/cebix/macemu/issues/271
>=20
> (and yes, this is my fault, I should've raised this on the ML with the
> regression tracker and all, but I tried to write my own fix then
> realized it was trickier than it looked and pinged Liam)

No problem at all, but since the links are available I will put them
into the changelog.

Thanks,
Liam

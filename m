Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56730779756
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbjHKSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjHKSwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 14:52:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E7A30DC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 11:52:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDcHQh002201;
        Fri, 11 Aug 2023 18:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=c0qsHZ84arFUN8wuvVl1flyKPvElSEkrD/dc451yRy8=;
 b=HVu2ZWQJn4OA3JdUQR59FPgKIAjX51cymoY0g00yQIlobOl1C2Cqms8Ry5J0Wnz6f+VS
 8xHOjaWJv1EZsY9eHFqviB+kmSJ5sHwakhLODvF9TwEkcmCeIcYX+r8ZntvatgGFgiUi
 w17EoY64rU6yj7fkM8ZCAVePB3MhZZU6wcxjTcs54fopA0qLkyUHe4CXm7q/7rnUBHwL
 KOuBuUKvm55cSLfav1YgA5EcaPc6wGynF1lKQ+vRvX4yskV7tFuRh1C5mMb6irHJPzyQ
 ZzUFJoLG9xVSUGTiO9/IU20yL6laN7thqa1RBbDbfh4MUrfOWaggQESWP6DhcE9yoVwD bQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ychpw2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 18:51:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BICkso033487;
        Fri, 11 Aug 2023 18:51:41 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvaqfv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 18:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wuclc2ho8RO3DHS+uDwEPVGZavUNu9wHDR8JJSMRlH1s5Sg5Nrh2/oGak520XRo7t/Ek9hZE0S2f8gV9aMw52zX7IVikMWOKwqwdiaZep9QVoDCiPTpMpkhl/JIo7e1GlugOQrUkjrydoerO/QrLO6MCrzRJDKRjtnw4kUwz9g4L0dfreNUPHSl+W2hHtIAJfbonx38CN6NMmKb7G4DcHOoSnoWK1FDYaMvZ2s/2pA90Dl2a5/n1FREo/3GfHl/QnXGNLwdnwEEnZbtybOiHBoT5oTIqGLUrAwNWfFB2HS0hlbQ9weilYFiiUjXRd9hNXHyHr5wwtx8kj940yQODAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0qsHZ84arFUN8wuvVl1flyKPvElSEkrD/dc451yRy8=;
 b=DdTucDpFlrXFYLX1FYKbD3Ls3N0uDiFlb1tVkZ2RVHW0jpRB+4m8h/DYbr3cA3V7NYB3nnOMJolutXVjtAueC8YxSG6jxvUbrp830nZL3CbiW3sMp7MTLq7tRSkwPDSiV4bHgo6Nt3MRmhhFe4P+R1BBQybsnZR1IozZC/FVG/+RW10FmiZBZL5EWra9yyGz1PjBcrUoiZC3ROjX8Er/qIUBmHyB7Y8Wj4J08Ol40lt9+0TqUluqzLCjhO8xSHFoZyKTTzELCgbcNMTHC6iSTBbHfpmRZ3X7dm4KRZJq/BxGVeflOP/ahw2vF6x5O9jtGH/Lu5ONVESULQHnaur+8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0qsHZ84arFUN8wuvVl1flyKPvElSEkrD/dc451yRy8=;
 b=eGVz4xRalTQYszDKaa596HeeUIdf9wF51NDLbJfR/Uyq8DBdEGi6OtTv0IGX3ICGTC/4vdWUv+rVXnzQWd+Wh2B/VrNLMeX+XtUHWyWOZsQKdYNvPl9eMbgKwRrEqT15fFx3AAOWgYma0clMQejrrxsGI7je/TC//LDyl3ANRqI=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5234.namprd10.prod.outlook.com (2603:10b6:208:30c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Fri, 11 Aug
 2023 18:51:38 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::2a3e:cf81:52db:a66a%4]) with mapi id 15.20.6678.020; Fri, 11 Aug 2023
 18:51:38 +0000
Message-ID: <b2b02526-913d-42a9-9d23-59badf5b96db@oracle.com>
Date:   Fri, 11 Aug 2023 13:51:36 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        brauner@kernel.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <20230720090415-mutt-send-email-mst@kernel.org>
 <dcd74064-7617-c895-4f78-cb46ef1d582b@oracle.com>
 <20230810145528-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230810145528-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:4:ad::19) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5234:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de562b8-d734-4ea5-02fe-08db9a9bfe56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OwB5fmELNgHc7wmZGi2NqCsR0b2I/CyzVEFp/7ayDI8YDgsqcvXDFQWU/otn6XvxOSeNVxnLIQ+2128XL9OPknXzz4N1i+DBx1VxZrhMpZxR6/vpG/mTMnMxkkDg8Vb4S4tNWXmLXXHDp6aAhooA7Ki4KcHOmHPt2aV7dd+ps7joE2rUQnyySkywRmthixcbA/OBPD34Kpw1i7Z+OjGENKaObJVj7cJHNIKBmD4ZkPqhmF3q/acFI7nA5Kx2kjgGyX71uN2xLppcPPROy9eiXoh+BaEnacRPX83LKV72H37Q0dqh7DC4foj5KmHC/6TMWDWPNN6knPLPX7K7PyD4GpB3x5vqDa8qF8rYaqtGLyoB3X9OhygmmpS5xgAfqrOwLCoworOBwF6Q2paX2OteiYmg8YzlJVrZWf0YbihlatzNOkv+RgosqLknKR5+5PAAeOUIBzntqL2K4yubNnDKkDrrOCJFjT20ZKIRrcqX8zxalViClj8bMFrbJkbBh7BO0kYMZhMhwVB+t9N+Bu9YppWjAAEFPV9i1SDAnvHhudvdaC2GIbvEaHMak3IdiLNgilw96BQhrARpJdKdRofV1BQ5WK+lT/XfTMpTUFqARdsxN1mfMAOk4bW36MZe9LF7wgra0o2+3YewXqbCzLmwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(1800799006)(186006)(451199021)(36756003)(38100700002)(6916009)(66556008)(4326008)(8936002)(8676002)(66476007)(41300700001)(478600001)(316002)(83380400001)(26005)(31686004)(53546011)(2616005)(6486002)(6506007)(966005)(6512007)(86362001)(31696002)(5660300002)(7416002)(66946007)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmZMc2JCUDIwU2V3SXkvTG1xemlJUEdmblB4c0hxTHN6Um51dmlQVVBDZWpP?=
 =?utf-8?B?WkxTTnNXcmRmWTNIaTdMU1B4R3FobEtrRFZQNk13azFRU0VveFBhWTVWQXRV?=
 =?utf-8?B?WDlhYkIvRjFWckJ6K3dWWVlicko5RnlOOEcvbXBkVjNrcWhsc0ZpdWNiNnBZ?=
 =?utf-8?B?dW5DQ2tscVIrM2FWVUpxREVBZGN5TnZ6ZjVnR01ZMXBHUTAzdkVGQVltN3Nt?=
 =?utf-8?B?azU2QVJOejUxM0l3Ry8rNGxzZzEyTGZmT1dHZ1JFUWFzSEloQ1c1d0QvU3NJ?=
 =?utf-8?B?TS9qWlp3dk91NDFVaHN6bHNJRGd1c2VFcXQ1VEtDdkpmUzlSaDk1enFHbDZM?=
 =?utf-8?B?NDFYcTU2TUNDMGdOK0ZQMUhSb3V6ejNMYi9YM0h1dmdWSWtBY3liT2RFbk4z?=
 =?utf-8?B?Y3Y1MEd1RWhuaEZqcFJMK1dHVjRpMFl6amdVamFXemZxQlFwMjExVlVGeE9z?=
 =?utf-8?B?Wm1LWnhOU0RXcE9lOVpVN3VrWlJGc3hYWk1BdkVtb1FYaVZaYXVlVkNsQlht?=
 =?utf-8?B?ZUtlR1BUS3FiaHU3bzJyUTgrK1RkMzFPbjVLRlRMQlEyWHcweFhCY3FMSmg2?=
 =?utf-8?B?YjNtZHZGdVZrd0FZOUp0RWpVeWtoQ0ViMWt1VkJzLzNhWW1qd1JMNytBSDV3?=
 =?utf-8?B?TlBnTW9Gb3RCTWpqQ3BEMHY0MEJmNS9iYkJ2aVlkNkhtTW9LY05tQ3BvTlpn?=
 =?utf-8?B?YlF3VmNxcUtFdHVjMnowaUZhMGNkSE0xcUMyK205WlQwNmlvNkVoREx4eWpI?=
 =?utf-8?B?Q0lSUUpxcllPZml1SlVvaTZ6V2dTWHZoMVZBajI5MUpTSGd3WTR5cE1GNEM4?=
 =?utf-8?B?WEpwb00rbFFCVUNQb2FlQ3BmbmpvRkdLN3hvbUVsR3ZYWThTc2JadzdFcHRI?=
 =?utf-8?B?emp3M3pNNUhPTDFiQ2xpWlJEL3JWYWEzcWVPWUY2d2M0djNycG9VcUhNQzJT?=
 =?utf-8?B?K2NvQnlvQjFYTVZNTEZ2ZVkvR0hGdXlhWGNsSTBxeXVQU2l3V0FJQWJiYmM2?=
 =?utf-8?B?VmZacWNCcks5eVQ2STlNUlpXUlFtV21jQjFoRkJsV1E4SVcrWkJtVXdQc2NJ?=
 =?utf-8?B?cmFmYlJxdnVGTGNaSHA2OG1vK0NmRkRETzBqWWtpbVNzRnBsd3RNWVl6Y0s1?=
 =?utf-8?B?WWRVaGVKQ1NPNk5wSGgvZVRpMk8vWnk1NXhjSmpXZXhBbDRDSXpUc0RWcHp6?=
 =?utf-8?B?SkVoelVhV2lYeGJOTUR4UVByREpQNEx2VXV1cWYxSlh1RUxJUGtndVNSWG1p?=
 =?utf-8?B?czJSRWlXZHQ2TEE2WnVrcXFGbFJNWWp5RDFUMWt0Zkk2TTR0NXltSHhEY2pN?=
 =?utf-8?B?OVlHZkM1S05PN3RMSVlSQlh4NHBtUlVSNGlCczBpRWk4N2hjSGZLTm15Zm1L?=
 =?utf-8?B?ek15UE5MRDhZbHNtODBuWnJoSytaeUZrdzVvSWx6VnFEa3lVT1dET2hHVEpy?=
 =?utf-8?B?SVpwMUxxcEFaT04xcVlrRk1lUmJyQTMrcklzWEcxczcwTHM0L3Uvc0dIL3Er?=
 =?utf-8?B?NUFRV2s3eUVBd0tQck9KM2hSa0JFaitqK3FSditlUFo5R0VER3JvVWVoQkZ6?=
 =?utf-8?B?V3pWbEhsZzFCVUhaclc0cEtDZWxjbU5DRUtjdUVibnNGcm5BcDhJTVB4QjVp?=
 =?utf-8?B?QUhIQndiNnhETHMzdEtlK3dSTE5Gd3lqejY2SStpMlVuYU5nNkpnVGhONmxN?=
 =?utf-8?B?NHRLdmVrNHFQbFlybTJ5Y213L1M3OVhiTUg0eGc2Z1IrN2Z1VTI4L2ZERFFS?=
 =?utf-8?B?aHhRRXg2ZmtDK0F0R2dNblVUTG1yWXVXWFJvYTRRVXl5QXNKWGV0ZGFTQzRK?=
 =?utf-8?B?OFQ0L1ZpUnd5NEc2cHFDZHlIVVkwdkprbDVDZ3ZrVlBGbDFEQWJjWjdRV29w?=
 =?utf-8?B?VFUzUDNpT1JnYi9VS2lMTHE5QVlNQlNONm9meDV6MDZaZVNaUzdTTVErTXp4?=
 =?utf-8?B?aVVhTE5KZFpmZ1VJeGduWVhXSEN5TVZVOTNNTEI4TkFyRk4yRHNNMUg1cmtm?=
 =?utf-8?B?M293Y1FjLzZMRkpya0o3WXBLSThlNHpxTVJzZ1ljdFFuc0tVQmZVaHdGUE9U?=
 =?utf-8?B?cmFyUUxuZ3oyVVZwWGZaTStMU3FMQVlTenhwczlOYm9FSkJnTGJhYmw2OUs2?=
 =?utf-8?B?bXkzU0ZVSll5WHhieWVnV3hlekZIZHBZaXlJMGw1eGRXQU5KSjlPczJVWUc2?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bnlzVmlzVUk1UUpmZHkvWStjTFUyc3N5QWQzc0F5VnEyUGY2dFVQbWhFVW1m?=
 =?utf-8?B?enlHbUNFQi9zQmVWMnNld1ZaQlFIS1FKQkFLRnhXSGRWd1dvVENTY0tnalh4?=
 =?utf-8?B?QkRIRTAwZXc1ZlB5L2grWmxhMEUrR0JBSDF1UUpGbmQzbkhodUpWWWlqbTdP?=
 =?utf-8?B?REtZZFpKcmZRMnVPNEdlZzJ4VVdNOVlJdkxtbUNvTHY5aDhDRFJjNHFhdVZF?=
 =?utf-8?B?dm5odkhrMk9YS1c2MkFhMFBOR0xmaVJXUnNObjAwTzFybHhZZmhqWkVkKzZX?=
 =?utf-8?B?SzRZMkduNGp2K21iZWRqOXhRS3hDeE5mRFJlU0hFQ3h6NXdna2poTmt4d05n?=
 =?utf-8?B?Z2FaUFloMnVMajBicHdxZHdydTRuR2dOVUMzWkx5Y0MzUjE4QW5vWEZ1TVRt?=
 =?utf-8?B?YjliZnpndk4wZFk2NkFBaGpyTUthTDhvWjliN1NYM1h3MUpzRGdmaytZK2NO?=
 =?utf-8?B?cEU5R0t3TlN3d1BjOGUza2dOQ0QreXJmYVlxNm9pNHRNVW84ZmVhNlhjZEk5?=
 =?utf-8?B?NS9OWmlOYURJUmlGamtTQlVZeXplMGxjOXV6OXlIRStnV004bGNjczZCdUJx?=
 =?utf-8?B?bDdTODF0U3FrWkpKVi9HakRYZ2Q3YkFwcnhnRkwwWkxpN3ZBYzF5ZW9INlZp?=
 =?utf-8?B?Tll3c3UzaG0yamFZS2V6N1RjYnVKeUVzZE5VcFhMSkpCZVNucG1vV2pMZ04r?=
 =?utf-8?B?bDBiUldZT3h0WTNlNVJrTDBMZ2E4ZWRBeHBlYzU0ZTl4clZJMjhUV0VhSVdM?=
 =?utf-8?B?OEJXaVFoZ3BxNU5EUURlNXY3bk03NWFCUHRITTN2VTB5dmtFSmY4dUlraEF6?=
 =?utf-8?B?TzZadzNleGlVMk1uV0FLcjBidzhJTHRJT1NTK1AyVVNxZm1qb3R3aGxkV3VS?=
 =?utf-8?B?Q09OWEY0QVBuOUhiSjQ3Lzh1ZzR1MGVEMlNiMDJHbUNKWW1qdFRiejJad2J1?=
 =?utf-8?B?YWhDSytzOXNoaUhaUDE5TUpJaDNidE44NHhwZG91U1phRXFpSzNaeSs0QzdG?=
 =?utf-8?B?SnZ3aXZqV1I3eWFZcGVOVzRONFBUa2wwQUNZVTB3b0J2RjVoNjI3Z0Z0M0tC?=
 =?utf-8?B?R2N2VzAvVlJUZnFwVCtQWTFSbSttQ1Ewb044QytyY1F3cmtvUHFObUJUSzFu?=
 =?utf-8?B?clo4TVRIU1Fqdk5vWGR2WFZ4bUdPRVJHeUt1SG96VHAzTzU1U0prdXFrR3RS?=
 =?utf-8?B?ZFUxNDgxOTZWdlhpdEF4ekZPdUl1ZjVqSjZWU0FYWXVaN3ZEa2I1UHMySXFp?=
 =?utf-8?B?QUtNOGcrNEx3WUx2cDhmWENGTVg1UkdLN2l2TFFON242anYxcTFIWERjQjNi?=
 =?utf-8?B?eHgwM0o3SnY2dXBTb1FLbWNTUkhyWjh5QlF4WkZIK2w4RFlCMXluL2pCbWxt?=
 =?utf-8?B?eU5VQ216STFuc1E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de562b8-d734-4ea5-02fe-08db9a9bfe56
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 18:51:38.2753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWPUBdrFkPxaBtX2RvODYtag4NKSn2fxWuSM0iEqgH2cJOMmxecWfGkCDBKzvz3a+02qqBFO+ccMBe8Dr75vakY4NjuyTGlxZxZ4YjBzeo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110172
X-Proofpoint-GUID: ZFLBINwttcIAJ71Uxk5syk8IWZH_hnXs
X-Proofpoint-ORIG-GUID: ZFLBINwttcIAJ71Uxk5syk8IWZH_hnXs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 1:57 PM, Michael S. Tsirkin wrote:
> On Sat, Jul 22, 2023 at 11:03:29PM -0500, michael.christie@oracle.com wrote:
>> On 7/20/23 8:06 AM, Michael S. Tsirkin wrote:
>>> On Thu, Feb 02, 2023 at 05:25:17PM -0600, Mike Christie wrote:
>>>> For vhost workers we use the kthread API which inherit's its values from
>>>> and checks against the kthreadd thread. This results in the wrong RLIMITs
>>>> being checked, so while tools like libvirt try to control the number of
>>>> threads based on the nproc rlimit setting we can end up creating more
>>>> threads than the user wanted.
>>>>
>>>> This patch has us use the vhost_task helpers which will inherit its
>>>> values/checks from the thread that owns the device similar to if we did
>>>> a clone in userspace. The vhost threads will now be counted in the nproc
>>>> rlimits. And we get features like cgroups and mm sharing automatically,
>>>> so we can remove those calls.
>>>>
>>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>>> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>>
>>> Hi Mike,
>>> So this seems to have caused a measureable regression in networking
>>> performance (about 30%). Take a look here, and there's a zip file
>>> with detailed measuraments attached:
>>>
>>> https://bugzilla.redhat.com/show_bug.cgi?id=2222603
>>>
>>>
>>> Could you take a look please?
>>> You can also ask reporter questions there assuming you
>>> have or can create a (free) account.
>>>
>>
>> Sorry for the late reply. I just got home from vacation.
>>
>> The account creation link seems to be down. I keep getting a
>> "unable to establish SMTP connection to bz-exim-prod port 25 " error.
>>
>> Can you give me Quan's email?
>>
>> I think I can replicate the problem. I just need some extra info from Quan:
>>
>> 1. Just double check that they are using RHEL 9 on the host running the VMs.
>> 2. The kernel config
>> 3. Any tuning that was done. Is tuned running in guest and/or host running the
>> VMs and what profile is being used in each.
>> 4. Number of vCPUs and virtqueues being used.
>> 5. Can they dump the contents of:
>>
>> /sys/kernel/debug/sched
>>
>> and
>>
>> sysctl  -a
>>
>> on the host running the VMs.
>>
>> 6. With the 6.4 kernel, can they also run a quick test and tell me if they set
>> the scheduler to batch:
>>
>> ps -T -o comm,pid,tid $QEMU_THREAD
>>
>> then for each vhost thread do:
>>
>> chrt -b -p 0 $VHOST_THREAD
>>
>> Does that end up increasing perf? When I do this I see throughput go up by
>> around 50% vs 6.3 when sessions was 16 or more (16 was the number of vCPUs
>> and virtqueues per net device in the VM). Note that I'm not saying that is a fix.
>> It's just a difference I noticed when running some other tests.
> 
> 
> Mike I'm unsure what to do at this point. Regressions are not nice
> but if the kernel is released with the new userspace api we won't
> be able to revert. So what's the plan?
> 

I'm sort of stumped. I still can't replicate the problem out of the box. 6.3 and
6.4 perform the same for me. I've tried your setup and settings and with different
combos of using things like tuned and irqbalance.

I can sort of force the issue. In 6.4, the vhost thread inherits it's settings
from the parent thread. In 6.3, the vhost thread inherits from kthreadd and we
would then reset the sched settings. So in 6.4 if I just tune the parent differently
I can cause different performance. If we want the 6.3 behavior we can do the patch
below.

However, I don't think you guys are hitting this because you are just running
qemu from the normal shell and were not doing anything fancy with the sched
settings.


diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
index da35e5b7f047..f2c2638d1106 100644
--- a/kernel/vhost_task.c
+++ b/kernel/vhost_task.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2021 Oracle Corporation
  */
+#include <uapi/linux/sched/types.h>
 #include <linux/slab.h>
 #include <linux/completion.h>
 #include <linux/sched/task.h>
@@ -22,9 +23,16 @@ struct vhost_task {
 
 static int vhost_task_fn(void *data)
 {
+	static const struct sched_param param = { .sched_priority = 0 };
 	struct vhost_task *vtsk = data;
 	bool dead = false;
 
+	/*
+	 * Don't inherit the parent's sched info, so we maintain compat from
+	 * when we used kthreads and it reset this info.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+
 	for (;;) {
 		bool did_work;
 







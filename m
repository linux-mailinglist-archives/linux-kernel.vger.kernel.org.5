Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73B78CC4B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238222AbjH2Sjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbjH2SjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C20110
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 11:39:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37THipsM026020;
        Tue, 29 Aug 2023 18:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4oFOrSGorZlp5X7Rkrzr3QvZlWdRO8CXSquQm9yCgJo=;
 b=FpSo2raE1UYBei+Cg38GVL8OJfK8KqbgadaVcKOFNx3vJeW1oqucNWfT3y5loFHvofQ3
 7XMR9hJp5bR61Jcnt3HGUCXUfX+plR2KebSQnHfImcBYU5yGflrl1MfKei1mrKHmSYBr
 C3Swu2+gtt5AYdClNgHSA1fZ9TtN55DNKz88hpkiyiQQlouSii4s9O4FoX3u8QAGvQN1
 TTfoFJqmR9ihr9w5UZ9z+oBYgIJmiUgYE9Ff1vpicx4mybGymbUnMKWDIYedkgwfHj3k
 naoHbI/o/h8ylrF4o9dmca3YDXx41GW71DfD0KUBbZhEWxvHQjJhP06Phk3TiKg9dhE0 iA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9j4dsaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 18:38:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37THCgRm004141;
        Tue, 29 Aug 2023 18:38:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6gbhjpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 18:38:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8OUC/pOnYPXG8A7QXyuTk9AAMqgIxZj6agvp0ivk+brPy3p8VxCyKWxpOD61Qm8glRUZNUG5q3n4VbrNrkcltJSmrHD+nkxIzS2LacoUqH8dMocDlS1JEOWToUMIVRXZBorHMCdHO3tYBzo6hXQ6p8r6EUFxyUGjihvOXKQrlvV2JN02qFyRdCRQmvsrFOfmFuQeKcLzezbEGTji5CXoBE6vKiiDZowAUjE6ATzgSndOdHqR2Sbl9s32GACBhEkmk0ilTVYImcuFZNrPMRB4+fQ4OaDX8ZqCUXUjVIk/IqCRiUZEjKyr3Gg2QUzDms9p+YSQnvnq4UxYn0ljy/dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oFOrSGorZlp5X7Rkrzr3QvZlWdRO8CXSquQm9yCgJo=;
 b=TqLn3H/c62P7EqA81Ce+7ARHUn8qLMJhcRjvm3NDGpyXWOQArFZOppNAlmzolHlsfCsDbrBuVBZKF5jS1+i57WC/fhFArR2PuW6T92IMkj+781hsz5WzXxFU6vwf6N7UgKto0UxqV1fxwF/XG4LrWox3szaaCAvgG6Cwfo2PPCikqLVvjXeZ+R4bGNudYrU1PdvvWt/lmQguQ3aOVdNQgE4hKUCiJMHZO93k03+UTAL9VPT3Z3vGpfTzN5PL8AbtVYIr4a01X9fnAss3QOHEk722Msj2045pAQYebuBZY730FpwfONYfkrkXCGi9U4CtbXcw3FZ+ERCHxMmIfPpSUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oFOrSGorZlp5X7Rkrzr3QvZlWdRO8CXSquQm9yCgJo=;
 b=zDUr/ADdjKTSQqJE1FkCappsFmKc0CQEiAzCpUv0Lt2srqMR+n5T31UagV4Nl3HOf+bTiTyGN0Y00TiuO60SZkkmPvm6IafH8Kv12ZjU97Zw3qdkwfqBjI6mAjz05q/FOYeVcVn/n3vUHbOMH8XoA9V4gSmrTtpli34iAmPltAA=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CY8PR10MB7195.namprd10.prod.outlook.com (2603:10b6:930:78::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 18:38:07 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::5943:cf66:5683:21be%4]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 18:38:07 +0000
Message-ID: <e62dbf53-9d74-45e5-b44e-53140672b8b5@oracle.com>
Date:   Tue, 29 Aug 2023 13:38:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>, shaggy@kernel.org,
        liushixin2@huawei.com
Cc:     linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
References: <20230829165244.460154-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230829165244.460154-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:610:11a::13) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CY8PR10MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cffc37-e970-4707-610f-08dba8bf1690
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X9qkgnn8aMfRWBnkdgJ0yQtugSFApjSxLVOaFpi1cr9MdDQUhBlgM33oOsc8TcQyKU3ietGZmJSL/LJluWBepam0HR+OE7Xp/xc51M58mK+GspoKHJDnAZ8dqyv/mnC4ZgYg+Ss+hUgAdBgi0r5+dmbioRJvf3V45cLBSxfWH4PMUfM7YA2tdY7oyuyWa0nfLe7G1btxzXwMRT5E9SRTRZ5o9DpGtD/cG0HQ5wsHOY6bm3UTf2wxJTHZNV98JyGT25H0m+CuhbNj4cePAxU98Fun0Tk1tRdtrQsCl52jvSOzuR9rHF+nkqeiF0ioBTFN+SBWasv320Vdkdqm1z6SZcfSrnoool5urI65ItaqiFXCqHqHeu4Z0WauMkuZD3aS046i35VXFCIZrm3kzrCxmODcS3tnkKypAf4ZncUCc//iqLGDbIDj9yIBkeshN+x+iK5VV9mXy9O5hMwwpgU2x3XOC3rIUlk8YeJk+gV4iayJe7g8qop2NzaOvw/m+0+99AMXTycyNc6Z28ZE5zFxzfRl5lwdvMWSg8j6LVdHSPEBdGf+Gk9DPiPU2yOoBD/xfDrCo4Bz6cZjQFXB64LOJfw+vWL+n2IR3RvTUSv9ofECnv97pRqVMq8887W3FZmWbKzmSJv4M0CI6zGTxpbfmppNGM8GSVlli2+ABehegx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(186009)(451199024)(1800799009)(41300700001)(26005)(31696002)(6666004)(86362001)(38100700002)(83380400001)(478600001)(966005)(2616005)(6512007)(6506007)(6486002)(66476007)(66946007)(2906002)(36756003)(316002)(66556008)(5660300002)(4326008)(8676002)(8936002)(44832011)(31686004)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXRCZlMrM0h0c3NWV0FZbUo0N3FFZHNlZk1Dd0U2UFNBalFWZmtrNTlKTEox?=
 =?utf-8?B?MTRQaS9LMmh0Y1YwS0hXV1l1elZpbEY1b29UelROKzg1RXJKOW1tSU5uZHBQ?=
 =?utf-8?B?d1dNVit1QWpVc0RESnMxWXZXdS9uS24zUGlpTlZaYVFZK2hEZ1NqSTlsK0tn?=
 =?utf-8?B?Vk02aGVzbjlWMlFYWVZNazlRbE5zdnlWV09hemRSczNjNWFkaVErUUxhbUpO?=
 =?utf-8?B?VlVpUDFsc0VVOC9EVjJ2blRNUDdrOHVTVHJDS3JvYUtZZVJuTGJYemV2Vk1y?=
 =?utf-8?B?dlB4dkJtWTVpZFVkTllNL2pOemo0Q0NGL1ZGWDB0dmIxNFJMdVR0NUYzbEs3?=
 =?utf-8?B?SVdvazF5L1JzVlBZdlhxNWM2dy9HQTBGRHFzblNOclJtK3JWSm9CalVLVHU3?=
 =?utf-8?B?TEZsYVJSaGMyZytRQzdJb0pLNVlzK2I3K1VpZktPZGowOGttUnRLbDZOK1VO?=
 =?utf-8?B?NDVIUmxkdWNNd1YxcE9jRjd3azcyMkZ4TkEwUzk0ZjFlMENFL2Z0aDUyT29t?=
 =?utf-8?B?MUcvM1pMYTdPS0FCT2FXcTdRZnRPcmlXZVBzMDVadFdmTExVVk5JKy9GU2Rw?=
 =?utf-8?B?TDdmZDA0cTY0R0laNFprMzZVaW5vaDVNUmJFbFpzRHJ2MFVTcFkyaXM2WkdJ?=
 =?utf-8?B?b20vSEtvQWVqVFNVSnhNb2VtZ3NHVkhxaXJQZTJ4L1RSdDVDK0NxVTMxR1lx?=
 =?utf-8?B?WmpIN1FvZ2hIUlZFL1RwMk1JZmh5dHZqT3lxbUwwWjdmTVZ5aEptNk1YcUc3?=
 =?utf-8?B?Z0tMZm1YTnRRa2gwT0tibDhaR3RJV09hV3IwVjZGdW5TSnRUKzhkaHBzWUwx?=
 =?utf-8?B?K016dVoxSEVuYmxUVlhpTTFYVVhiV29DR2Q5bmdiRDhVb0dzTGtneVUyWUFr?=
 =?utf-8?B?NG0vdUNYcTRPSGo1QVZnTmxTTS9jeG1hUkRCWFJ4anBqcy85ZmlGalREUHQr?=
 =?utf-8?B?bTMyV3RSalVXZDlQYklMcWNSdVM1NFZObkZiSk84RWNLL3pHNGtTc0RKTDRU?=
 =?utf-8?B?K0g1a05PVkgvQVZvT3ZZWnB3Q2xCYmNnZTU0S3RiTW94UXRjMWxWbkg1WXBQ?=
 =?utf-8?B?cDF3RURVcFZpQnkyaDEyZVE3VGhSRUEvSjJZTkx5NmZGS2xOY3hxSXpQUmw1?=
 =?utf-8?B?TFRFQlRQc09HcHhOeTJhc0xJVTFlZUc1ZzczbVFQRTkrZXl0Vkdoem9yL1hw?=
 =?utf-8?B?d0ZEMDR4ZmlUNkgrUmxIc3NGVnVndGFaWE9nN1NHT0d6SHRjMGVUQkpaQWkr?=
 =?utf-8?B?M2N2WVpKN2gzZkpSTDlRSEgxRDFGTEk3ckplVXpDNlUzdHJ4eWszYytxVnhJ?=
 =?utf-8?B?YnlvODlyRWxNZ0NGZUdoVnVEbDdnSjNFU2NXL1lPVzhTdzFRNExBMVVIL3VU?=
 =?utf-8?B?MXVtejBjMXhGL0xacEt3N1RTQUJQbk1nVjdyajBpQjZJd2FiU2Q1WVRnSTIr?=
 =?utf-8?B?anNvdTA4ejVhMy9LUS9NTEtBVjBXT0dkRHZqak9EMlFwWFdFb0t5czR2cDlp?=
 =?utf-8?B?Nmx2Y3R0d2NpRXQrb0hWN3FSV0Rmc25SM21SOHh1QVl2alRMN2ovRHFyRVYy?=
 =?utf-8?B?MCtSWFZLN0dzcklrVzdXb3ZqZCtwdG5Lc0gvZDE5UFJ5NnV6QitncVNGQlhX?=
 =?utf-8?B?enZYMm9Yand2NlpPbXNlMi9pYzkySW5jL2tTOUxUZVd2eFpYclViNUpYSWdn?=
 =?utf-8?B?YlphS0ZqaHgzOVZkcElKaDV2QUhYd2NwVTVDRDMyRzAzUjZCQXJabktpYjd2?=
 =?utf-8?B?VHBrODVCMkM2dS9UaEg1bm8xKzV3VCtEQlJuVDA1L0IyckYrZjVncThvVGVB?=
 =?utf-8?B?N2xzdlVjd2ZnUkM1K1YrN2lCSDhyZFp6ZjNqbSsvVGFndGdvQ1JSNjlVNDVU?=
 =?utf-8?B?YTZ1NVlZb0hObmVYaDI5QlliUjBlbEQrSU45UmNiOGRFdFlmbmliTGdUbWho?=
 =?utf-8?B?L3NiRU5iaDVpeTJYaFNiUTZlVnVyUDVLbHhjRTIvZ2U4TUY3aHBtMTJWSk16?=
 =?utf-8?B?QTF1WmFla2FadzhyTHNmNklHUmN5TjhrMlphUkF0NUNGZllCZ3RtS1Z1RmZT?=
 =?utf-8?B?NlFza0x6ajlqQWxaUWNCb2lZbXA1Q0pyeEJrQ3NDVzZ4TkJkMkJQU1Y0empK?=
 =?utf-8?B?UElPNHY1ekFWYTNzQ2wyeFJ3dS9Obk5LdnVQenRON04wVXAvUWNhWXFjUUoz?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q1MyMTQ3SWdjQzQxMkFSWjFYZGpXWUQxOUxZUkNXWTFpaTlsTDlnOGNNYnBw?=
 =?utf-8?B?eVI0RDRVcjhMWVhvUGR5TDBBYUovU3FyZmpFb0VHUEhlUGtReFdCclVYVWZ2?=
 =?utf-8?B?Z0ZndjNhWnRIRUNQRzNYVUlJN1E1QkNqZ0doVWhwQVlVNHhrc0Q1R2tlL3Jh?=
 =?utf-8?B?Smd0YUluRXd0S1BuNmhmaXNaazNaYlhTTTQ0UmtiTDdpVnZkS25ZbU12TFdU?=
 =?utf-8?B?b0VGOXVNUE9QRWFoaFl0QkJRUGRhcGloTG02UjFxQmZLaWxVZ2dMdWlrVW1N?=
 =?utf-8?B?Tmorb2dwYXkzTjBLSzh4S2FnQldhS2xZVWQvVjVpTnlkL0tJUnFXSlJwTDBE?=
 =?utf-8?B?UWYvWUhzT09Cc1gzZWxKQk5DWEh1S3owY2hxNjNmZ0lnMGJvZnB5RFkvZU12?=
 =?utf-8?B?a0cwN3l4eTl3UjM4SEZ5YmVPUTU5U0dpVkgzUzZwcVJaR3N0SUNHZHFmUERv?=
 =?utf-8?B?a1NFeU12K1k3KzhLcnY0OGhhS2ZtbWhmSE05c0FTSGdWYTNTa1FPeDdvTDhC?=
 =?utf-8?B?cUQrVE1tdnUwU1BOMGQ3bGpjelBJUFBrbTRSMEV1azJYZGRnMUlEZHVtYmt5?=
 =?utf-8?B?MHZDcnAzUHMwVytOdnJWdmdlZlZIbkc4YmF4QklXcG14dXVXaGg3WEJxdFNS?=
 =?utf-8?B?Z3JOa3Zob2hqZWVZTEsyeGhsazBaUWVvM2xFcWRlWktnSEtsSDBiTWlWYjU1?=
 =?utf-8?B?RXJKaW1ta1VYUmdHUmVJaEtpbnhOSHRqYWU5K3J6RmpMMDZOZkltaytvNTd3?=
 =?utf-8?B?dC9ZdnlsQ2VNaEY0bTA3WGtnZ3lOODJNWUpHUDRxTVdGSHo1cXlzTXN2YmVi?=
 =?utf-8?B?NnJwYWg4c3lPY2gxNHJzQ0J3NFZBZ1BCWDVrbW9zV2dKcmhtWUpOYWU2N0VF?=
 =?utf-8?B?Uzg4dit2cTNJOFcrV3BxM0xNQWh2Q3BUc1VuNkNRc0dLQ29vckh1M25jcks1?=
 =?utf-8?B?bmZDNUwwejF0NzU1YmRtcitQQVRKRDJseTU5c1duUXJGV2VQTE1DOUVZbElM?=
 =?utf-8?B?MHc1cmYrWTZIejZUa3lGUEorREk5K3ZyVmdDbkQ5eGMyRmttOTlrVHl5NmZ0?=
 =?utf-8?B?ZzFwYjZCaitDVkYyWGVVbldmd0JJZ1BMajRQcW8wM3k5dUFSTEllTlhXZDdL?=
 =?utf-8?B?QnFSNnZBZlR2cG1xeUY0am9yMGk1Z09HazZqMC9nRGZWZk5VdExQWXdFSjM2?=
 =?utf-8?B?UldMZkJuWWdyRkQ2Q29sQ3JtOFdHU1VUVmNoZFV6RXM3czJwQnoydDZIREpv?=
 =?utf-8?B?dk1NNEtKVFR3QXB5NjNlR1lTcXFQaGc0WGpXK2ZLODRMcVFoSWplbkMwZjFk?=
 =?utf-8?B?RlZtNDRuN0Q0UFV1dlZnZmg3ODJiWkpQVEZOWDFOTjgwM3JnK2JzOVJoOEtH?=
 =?utf-8?Q?OLqWsI2gIfXyp2JC/NJcoRdSMWaRLWqs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9cffc37-e970-4707-610f-08dba8bf1690
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 18:38:07.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTlhdDO9JTglU1T8oj+CHbSOEL9q5qN4oLCUogjYmVfAYbsxLzxEJdwhvD4Wap05BDv6Sh8eWLQQWjcMzJeenYTyAs7pCqzF2QwtOonH1ng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7195
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290162
X-Proofpoint-GUID: 6VqrZIx9KsZYKB3WPuRJlCqvrGJGRII3
X-Proofpoint-ORIG-GUID: 6VqrZIx9KsZYKB3WPuRJlCqvrGJGRII3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/23 11:52AM, Manas Ghandat wrote:
> Currently while searching for dmtree_t for sufficient free blocks there
> is an array out of bounds while getting element in tp->dm_stree. Added
> the required bound check.
> 
> Ps: After I added the check I am getting the following log
> 
> [   22.661748][ T4425] ERROR: (device loop0): dbAllocAny: unable to allocate blocks
> [   22.661748][ T4425]
> [   22.665536][ T4425] ERROR: (device loop0): remounting filesystem as read-only
> [   22.667856][ T4425] jfs_mkdir: dtInsert returned -EIO
> [   22.669750][ T4425] ERROR: (device loop0): txAbort:
> 
> I was wondering if these checks are significant of not?

This won't work. dbFindLeaf() can be called from dbFindCtl() with struct 
dmapctl whose stree index can be as high as CTLTREESIZE which is larger 
than TREESIZE. A check against CTLTREESIZE might be better than nothing 
at all but won't necessarily detect an overflow. Currently, dbFindLeaf 
doesn't have anything to tell it which tree it is working on.

We could pass in the treesize as an argument to dbFindCtl() if we can't 
come up with something simpler.

Shaggy

> 
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
> ---
>   fs/jfs/jfs_dmap.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a14a0f18a4c4..5af17b2287be 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2948,6 +2948,10 @@ static int dbFindLeaf(dmtree_t * tp, int l2nb, int *leafidx)
>   			/* sufficient free space found.  move to the next
>   			 * level (or quit if this is the last level).
>   			 */
> +
> +			if (x + n > TREESIZE)
> +				return -ENOSPC;
> +
>   			if (l2nb <= tp->dmt_stree[x + n])
>   				break;
>   		}

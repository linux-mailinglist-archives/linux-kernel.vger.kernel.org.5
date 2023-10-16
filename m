Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918377CB4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233867AbjJPUat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:30:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE471D9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:30:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKOMsF014467;
        Mon, 16 Oct 2023 20:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=pEcsshLIuJTG6cFcuMmwU0xnl8h4xG0RX5t37dSgu5byR9zUqZmnRNDMOB1JQ0iVOvOH
 LsjvE9UHbMFu4cJN7cY6dq2USaIx4B8IsueMxR+TNPmJ9I3guHea0zckJldd7a9rND4r
 xdDSo7YRGu9RshTNvg1tCXSORZm5yQch5tkxyXs1dZGrASPb/S/UFR5GJWuLZ3lirl9K
 vLBU9Lf2uXZp5Jm2NT2oxu/l0G8Mb1V61e89yiNx8igP438XdFb6zLSi4+dj4uwQDiUn
 bx/MOCiWICwoOpa8ufbH3qOonTD2NyzbgafQYJ7hWzUDk56Flo3qrvP8qjBfNK2ebn9W wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu3qj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:30:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKCiAe040423;
        Mon, 16 Oct 2023 20:30:36 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfykd92q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 20:30:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNkJx8qLgodNn7TG1q2Seu2Eahhu1Gmi3/luBfUvivSob3O3tEYi1hr60x2TuCTZVzsQ4QFR6ncDYvNNz9BG02b9VMEuJPAyE9JqcdxsKfifk3gKY6yteQ4P49Qg3FRG6Q7/ICgfDDDPct2HE0ajhJsPlgwbgcjj4ZY6drf4z92i3Kx3y/LxgbE0Qo4rluFVLCk0da5KTt3QaANgf7+3heajf8WZclXaKmh+X3riR9qR6P0amEhu0rwmc3rjOu880QxwZtr+ocxYQBEJppWlmBo/FYmEJ9fW4sT5Z+ikeHnBZmPmUcwD7RE2JKKu8gwHRYqRgsYJmRIWoap4DtCcIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=hTRVABcL3TmqYqToBVInIluW9MAdZWIG2wGnwjLE/FcfyeKmKO+STXkRQkEOUWMaLZKQOHJsy5PvOmolCO7M6vctYovNVvPsHGNuJ09kCkBAEkj5pzvYDfHxcpfFAT094tMAdOppR1hNxu31HSr5Vz7X4lPBqOpsetZQSZyCrA+XkuZaMBN+Qmels8xiTPf6BcElsIVhII6HaPsN6uj7JDeP0ZT8i1jiEwJw+sDWpfUlMSRpT36m3mfrG5wXcuVBOIRJ8V0qvfz1Yiv7FOxjTb4MjfEFyIfcbpLH5xb1rvgzr0DOlTWH9vHS5JdDNzbJuTvW4K9rS6UcIlEIfVINMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6MYFzkag2TURtzsulr5U83rWjLmHkjG/TaB6FdCRfs=;
 b=f1dDog24w2fJIXKrExH46IyJ5owaLwjmb8/ho+JmRtQzw48dmeKvYQhfzQgDWdlU0V2ANhHzu33WPxUK+5Km8YaxeiOlf/NONg3Wtsmqbn1xVUyfe/OfPHA6NiyvCAp+G3YQSEvUFjTIL+6Xzf1neyc0aZIuESxqLnuxrIkKQFw=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by SJ0PR10MB7689.namprd10.prod.outlook.com (2603:10b6:a03:51a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Mon, 16 Oct
 2023 20:30:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 20:30:33 +0000
Message-ID: <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
Date:   Mon, 16 Oct 2023 13:30:26 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Eugenio Perez Martin <eperezma@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:5:40::15) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|SJ0PR10MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3fffb7-43be-45f9-da9c-08dbce86bf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+yndMnFcZT70jLAL7U3mIpMVxwWfqr0ZqJw9d6oUiGVFmVNHruTelho07G1kR+ismws6t6/ikX09uihg/x/qzPUv2RHZiiUpeWjPogXohgBKM0UCgITk08fG51Qmz1Z8P5jUVFEV41mkqCRRQ3R+ejzUrRv9bW0ys+JfPJdFGZVhp6NDOLA374QLqp/KfzVdjKAoyD2jRoZBt2ldk8fs36fgJNXtdDMNKiizOkfepkx4IxWUMsYHhvClFW4d/uK5od7FP/Se+zqeRB6LK3CsH1KoJkDVG6zbnFUoyBYTAnDiy6DZK30nXXT7Ris5bpfipQMvrcIL17r7ChPsI9Ftcpl8ec0evJt0ZWlM6fGYhc5l0SL42BgcdjH9UTC5JiNAE4a8LotOWUzCa5tCO6r3WzJQpUtzMwTRcMY0buq7gB2I2+y/27P9sDvS0XkNikjriQYxKCzUFwv27oE8u7WmX7xb2l9Wgmw0Cy48pqauD3r4WUeH2pyU0bgUFO4IrVJDcxmWYSwAci8oSWlct9ZV6NCrhTvXi9/c6ZEoT5UWyLhv01yif8Lp+LQk9IdIMjOvoDzGX6sct+WgiNaMZRDGP/G6l5h5jdp36nfJ3r6s0P+jAuyCXjtTbGSSgwhgivmGpCjPZM1esrpTwUYz9XEn+I3XKfVnCRwyC5XVXkZgbqkCSRnyYcSlBa475yYeBfOf9ZwUv71XKhvZJ7jBHnGKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6506007)(36916002)(6666004)(53546011)(83380400001)(31686004)(26005)(6512007)(2616005)(66899024)(38100700002)(86362001)(31696002)(2906002)(5660300002)(6486002)(4326008)(8936002)(8676002)(66946007)(110136005)(41300700001)(36756003)(66476007)(316002)(66556008)(966005)(478600001)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXMwbTFHWkxROVRBNU1kRi9YQ1Nva1JxWEtwNks0UFFHK1ZIcDE0R3g3WWZE?=
 =?utf-8?B?MTE5NmF3a0lSNEZqRy8zNHVndmFWY2lrSHk0ZE9pdW9vZ3A2NGV1ZW1Eb1Ny?=
 =?utf-8?B?Q2o0bGVyTWdMQmNPWG90RWtiZmgvVktlNU40UzJjbWUwWlp0ZWN1a2szbVVj?=
 =?utf-8?B?ZExGd0xXL0xLbFVNcDVzRFR3K2NRb0JMOENXNXN4dko4aWxFd0dkdTl5cGVu?=
 =?utf-8?B?c3VBZ3BpMC9pVDZxMkd4dW4wdjJFdEcxb1VrWHVNZlJJblViUjN3U1dQSXNs?=
 =?utf-8?B?clE0RlFzME1TTzhEL3llNERtZllLSC9mYlRuQXNubUlaNlZpZWs1SUJIS2F5?=
 =?utf-8?B?Y0RDSEZaRTdLYmlZTFRiL1pvalFRcCtmL1VpMVZjS0dxNmthSk5IYkVaMkpO?=
 =?utf-8?B?WCsrT3NYWkh0dnV0bExTU0FFVC9jbVBNV2xaRzRrVlRRelFCZVJ1OWg0OE55?=
 =?utf-8?B?QUVUVlloVHZPUEhnejEwenlONlNIZmcra1lzekpHbEptbkVoRHRrZFNGYW91?=
 =?utf-8?B?eG9tczJKVzVqWmZwNVRNZ0MvMWJBWCtzcjAwMlJpVmt1aGsxcjlRK1ArblFr?=
 =?utf-8?B?OFVxbmNNeW1UbUhzdnNXSy9Jd0tPYzhtcFRvcnQzcXNUZ1ZzdHJkKzUxL0JQ?=
 =?utf-8?B?STQzbW80M2FPMlVjbjhSc3k4YWVPdy9LYWUzUjNVaG1GKy9hcjRtNlZpWTVD?=
 =?utf-8?B?QktFaE8wZm9iMEtBV2dtQTdhRUR0dFdEdzN1alVCT3pmTFRrWWdGbnlDbWdL?=
 =?utf-8?B?WWxmTkhDeHQ3VjJ2VW5VNUpHN2dyRytTU1Z0aUVtdW4xYVNFbkRCWkcwdkcv?=
 =?utf-8?B?SVFMazRDbzZaWTlCY2R0azFOUHIwWTFyNjE4bWg5S29SVnpjZzdwT3lvamw0?=
 =?utf-8?B?K01oUEl0Z1M3Z3dUZ3FJTXdPSllqOXQzT1ltUmJ1M01JdHkxSERlNTBXMnJV?=
 =?utf-8?B?enVKdnJkQjRpUUg1dWNhOW5JVnd2M0Vzc01UUms5Rk5nTGdla1hKQnFicFhs?=
 =?utf-8?B?dWxYWlNTQnIwZ1NJMW9tSHJqVzNpNDZmaGhHcVVBdHFCN1Y3NlR5THk3bHRP?=
 =?utf-8?B?K3liUktiV3pJZkc1UlhzdzQ5a2Q5WW9BY3pjWC9OdHdjSnU5THhmeFpFTlNk?=
 =?utf-8?B?ZG1STkd1azdKUzVjQmFHeVBFWUNyU21TdkFCWXpTRmQ1MjA1TDJDOWwwOUxz?=
 =?utf-8?B?RVIwODR0SjM1OXBmVEhaWmpPRU05N29vTHBUS0RFQmowT0tOUHBQbkJ1OFIv?=
 =?utf-8?B?SU93YmUvUzVLQ3NGdlZzWVlQNSt3WlgwUGs3YnpTWXd3NGYrbjUzV3Q1aWRk?=
 =?utf-8?B?Vk9WTWxCM3BWSXFVZjZwbFhKTy9hWmM2RWhHcEFwMXhPZDR2TWpRdG9SNXNk?=
 =?utf-8?B?Z1djQm1wTG5TWTFQckl3U3JiaDQvdC9YM1FkSzRkU1lCWGh5K1VZc1R6VXVr?=
 =?utf-8?B?cDhabUd5UWNNUzFzRVg2VkNTUFFYOUM1WjJkUmdUUk1ycUxmV2lTaFdDVlZE?=
 =?utf-8?B?eHVlM0d6VkFvZFBkdFVKdlZ3WGhTMzVMdjRPZlZVdUt5aHZTVXgxa0I1aEVP?=
 =?utf-8?B?bGEwYjNxY3grT1RQS2NjQ0VoWXBpSm1FRk16UGFTd3BxTTd4VGIvL1g2MHBT?=
 =?utf-8?B?RDg2YndlbURERmNoQkFvckgxMWlXcmpST3ZhR29hWjNsR0tVM243bHlIellK?=
 =?utf-8?B?OTczNVJKbTM2U2tmYkg4VG5pQXZ6T0ZSVmVrcEJaWUN4UWNyRHZuUTh5b215?=
 =?utf-8?B?dWNpQzhibkgydFEvWEJXakdUOFd1bkYweEVxQWRsK0ZXOHNIb0FIUElkVENZ?=
 =?utf-8?B?WmtSaGVkZDBwcUQ5QlVqa2hFR2xSQkowaldxbFVEVlFUKzJEM0pYRFRIV1Fa?=
 =?utf-8?B?NWpjZWJFTkZ6QkJmZC9KWG5qSjFGU2xvOHNIam82WVhuQXhWL3RFZ1hFVGp6?=
 =?utf-8?B?dENCNjZIRHV4UWJ2VnFrdzFxWGgvWUdnNm9xTEZzNGxaU1F6VTlCeWFnZC91?=
 =?utf-8?B?TnRvUy9VcVYvMEhuSUo2TVZaS1diRDM3OFg4dE4wRDRMVXU5ekFPdUhHOExU?=
 =?utf-8?B?K295TGhINkVWVkdZSk96T2hnMzFldkNkdG9PQ2RzOWZCam1zb3dPclpyWmRP?=
 =?utf-8?Q?TZMJ6EqT/z5WNSpGSB0S78Haj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDR0aEI0cGpxc2d4QWgvTTRrbmF2UjlPaTFqSFluU3ozL082WE4xOXR0V3E5?=
 =?utf-8?B?MDFTd2duSnVFUjBRd1U0LzYrODFvOHM0azc3Y2l5RVk2M3VlRmNsbnRKVVVp?=
 =?utf-8?B?UWEydTlhVkVDQnU4c0I4eGJBSXVPWm4yaW9vRGZTSmZNZTdCbXpGYnRFNmps?=
 =?utf-8?B?di9BeEtWa0tpbmVYbGN5OSsrcG92WU55dk9Wb2I0WmY2TFB2WGwxYWZCWHFD?=
 =?utf-8?B?ZkJjelB6Sm80aXBIZlU5Yi95ZzFjMGpKVlZwMzFJVktIUTF3b01VeTQ0Vzdq?=
 =?utf-8?B?aHhMcjdsbWJLQXBrMS84R2NvTEtSSGoyampFa054MkEzVlV5cjdaZ0tISkND?=
 =?utf-8?B?MHdodkRFbjdwQjRzTHIvZVlaOHpmVDZTRmMxcFZEVFpsZFIzUFRRaEE5QTNZ?=
 =?utf-8?B?WjRzdWlNVDc2QjVJSCtQeGY4WTBuN2lSZDRXcTJzMnAwUlhJeWVQMElnbi9I?=
 =?utf-8?B?Rk9GN3Zxd1VwZVErRHRzZ3RvWmhiaW4yYlNaQkhCMUduYlIxY0VLajcrZDZ2?=
 =?utf-8?B?RDlXVVpYVlFiN0pJc2NqZVNmQVdyQklTS3hZYVIxWnhuai9VSE4vTkFCcFJi?=
 =?utf-8?B?SERkV29yOFk1QjFPanV1eGJEWFF6VkMwemxYUmo2SU9TVUlTR0hxcVFYWHJS?=
 =?utf-8?B?aWhQVnM3R05IMGlDaWM1ZVBxWlM3SmViUUh5SXo3bFNvdU1iM21NSGZzVmlU?=
 =?utf-8?B?eHVZL0E0Q1hOamIrem9Cc0tXTE00QXF4cExYTnUxNnVpbldCMkdMOVJuYnZV?=
 =?utf-8?B?QnFWL01ub2hYVFJ6Wkt3a21RYmFDaE8wUGZmd3poWGUzenNMZFBpc2Z2RlpW?=
 =?utf-8?B?VlRSeGxtZFFwS2orMGFHMHNZcXNoKzdyUXN4V2hDVld4WHRITVdteXQ2RHYz?=
 =?utf-8?B?cjdlT3RJa1J0bGFmd3JzWlRlQ2hUb1pDZXp4MWphZ1NnRTR2UEFzaDRLZFpR?=
 =?utf-8?B?NHA0N0N5U0duMlZ3cE9nZFpTZkVoNVEvRWJUc1dRdjBndXhpYU9CVkNQNzVL?=
 =?utf-8?B?dXRzOGFyMDk2a0hFc1ZBejdDZzloTFlRK3A1aGhvQWFkcHIxSHI4NmUzVHI1?=
 =?utf-8?B?RkdGVXRDTVpsU0xmbGd0bGx4S3ZRdTZla25mWWNOU1FqT3dOYWxZamdMeUNX?=
 =?utf-8?B?UG5iWjVSUGlCVWsvVlBoZDVQSzNmdGhMeDNVWENocTFkaEFseDdBeUp4QmJI?=
 =?utf-8?B?MEtma3RwOWQ2SE9MbGtmUXRoeFdxSDVyNEt6dGxSbDYxSHJMc0xOcHk2RkdV?=
 =?utf-8?Q?aiJ2laJ0xO1jWVt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3fffb7-43be-45f9-da9c-08dbce86bf30
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 20:30:33.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnXfAOYj7dje0kebpc1dTQlS8uAzF7c9VUsEVNIzZy028qbMJMMbsjgvA9d0RR9tFhIBTWkrRX3fHP+hnsYpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB7689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310160178
X-Proofpoint-GUID: 1Voe6IQ2JjRuABDwQ7TxCa7ed3vB5pDJ
X-Proofpoint-ORIG-GUID: 1Voe6IQ2JjRuABDwQ7TxCa7ed3vB5pDJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/2023 4:28 AM, Eugenio Perez Martin wrote:
> On Mon, Oct 16, 2023 at 8:33 AM Jason Wang <jasowang@redhat.com> wrote:
>> On Fri, Oct 13, 2023 at 3:36 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>
>>>
>>> On 10/12/2023 8:01 PM, Jason Wang wrote:
>>>> On Tue, Oct 10, 2023 at 5:05 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>>>>> Devices with on-chip IOMMU or vendor specific IOTLB implementation
>>>>> may need to restore iotlb mapping to the initial or default state
>>>>> using the .reset_map op, as it's desirable for some parent devices
>>>>> to solely manipulate mappings by its own, independent of virtio device
>>>>> state. For instance, device reset does not cause mapping go away on
>>>>> such IOTLB model in need of persistent mapping. Before vhost-vdpa
>>>>> is going away, give them a chance to reset iotlb back to the initial
>>>>> state in vhost_vdpa_cleanup().
>>>>>
>>>>> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
>>>>> ---
>>>>>    drivers/vhost/vdpa.c | 16 ++++++++++++++++
>>>>>    1 file changed, 16 insertions(+)
>>>>>
>>>>> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
>>>>> index 851535f..a3f8160 100644
>>>>> --- a/drivers/vhost/vdpa.c
>>>>> +++ b/drivers/vhost/vdpa.c
>>>>> @@ -131,6 +131,15 @@ static struct vhost_vdpa_as *vhost_vdpa_find_alloc_as(struct vhost_vdpa *v,
>>>>>           return vhost_vdpa_alloc_as(v, asid);
>>>>>    }
>>>>>
>>>>> +static void vhost_vdpa_reset_map(struct vhost_vdpa *v, u32 asid)
>>>>> +{
>>>>> +       struct vdpa_device *vdpa = v->vdpa;
>>>>> +       const struct vdpa_config_ops *ops = vdpa->config;
>>>>> +
>>>>> +       if (ops->reset_map)
>>>>> +               ops->reset_map(vdpa, asid);
>>>>> +}
>>>>> +
>>>>>    static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>    {
>>>>>           struct vhost_vdpa_as *as = asid_to_as(v, asid);
>>>>> @@ -140,6 +149,13 @@ static int vhost_vdpa_remove_as(struct vhost_vdpa *v, u32 asid)
>>>>>
>>>>>           hlist_del(&as->hash_link);
>>>>>           vhost_vdpa_iotlb_unmap(v, &as->iotlb, 0ULL, 0ULL - 1, asid);
>>>>> +       /*
>>>>> +        * Devices with vendor specific IOMMU may need to restore
>>>>> +        * iotlb to the initial or default state which is not done
>>>>> +        * through device reset, as the IOTLB mapping manipulation
>>>>> +        * could be decoupled from the virtio device life cycle.
>>>>> +        */
>>>> Should we do this according to whether IOTLB_PRESIST is set?
>>> Well, in theory this seems like so but it's unnecessary code change
>>> actually, as that is the way how vDPA parent behind platform IOMMU works
>>> today, and userspace doesn't break as of today. :)
>> Well, this is one question I've ever asked before. You have explained
>> that one of the reason that we don't break userspace is that they may
>> couple IOTLB reset with vDPA reset as well. One example is the Qemu.
>>
>>> As explained in previous threads [1][2], when IOTLB_PERSIST is not set
>>> it doesn't necessarily mean the iotlb will definitely be destroyed
>>> across reset (think about the platform IOMMU case), so userspace today
>>> is already tolerating enough with either good or bad IOMMU. This code of
>>> not checking IOTLB_PERSIST being set is intentional, there's no point to
>>> emulate bad IOMMU behavior even for older userspace (with improper
>>> emulation to be done it would result in even worse performance).
>> For two reasons:
>>
>> 1) backend features need acked by userspace this is by design
>> 2) keep the odd behaviour seems to be more safe as we can't audit
>> every userspace program
>>
> The old behavior (without flag ack) cannot be trusted already, as:
> * Devices using platform IOMMU (in other words, not implementing
> neither .set_map nor .dma_map) does not unmap memory at virtio reset.
> * Devices that implement .set_map or .dma_map (vdpa_sim, mlx5) do
> reset IOTLB, but in their parent ops (vdpasim_do_reset, prune_iotlb
> called from mlx5_vdpa_reset). With vdpa_sim patch removing the reset,
> now all backends work the same as far as I know., which was (and is)
> the way devices using the platform IOMMU works.
>
> The difference in behavior did not matter as QEMU unmaps all the
> memory unregistering the memory listener at vhost_vdpa_dev_start(...,
> started = false),
Exactly. It's not just QEMU, but any (older) userspace manipulates 
mappings through the vhost-vdpa iotlb interface has to unmap all 
mappings to workaround the vdpa parent driver bug. If they don't do 
explicit unmap, it would cause state inconsistency between vhost-vdpa 
and parent driver, then old mappings can't be restored, and new mapping 
can be added to iotlb after vDPA reset. There's no point to preserve 
this broken and inconsistent behavior between vhost-vdpa and parent 
driver, as userspace doesn't care at all!

> but the backend acknowledging this feature flag
> allows QEMU to make sure it is safe to skip this unmap & map in the
> case of vhost stop & start cycle.
>
> In that sense, this feature flag is actually a signal for userspace to
> know that the bug has been solved.
Right, I couldn't say it better than you do, thanks! The feature flag is 
more of an unusual means to indicating kernel bug having been fixed, 
rather than introduce a new feature or new kernel behavior ending up in 
change of userspace's expectation.

> Not offering it indicates that
> userspace cannot trust the kernel will retain the maps.
>
> Si-Wei or Dragos, please correct me if I've missed something. Feel
> free to use the text in case you find more clear in doc or patch log.
Sure, will do, thank you! Will post v2 adding these to the log.

Thanks,
-Siwei



>
> Thanks!
>
>> Thanks
>>
>>> I think
>>> the purpose of the IOTLB_PERSIST flag is just to give userspace 100%
>>> certainty of persistent iotlb mapping not getting lost across vdpa reset.
>>>
>>> Thanks,
>>> -Siwei
>>>
>>> [1]
>>> https://lore.kernel.org/virtualization/9f118fc9-4f6f-dd67-a291-be78152e47fd@oracle.com/
>>> [2]
>>> https://lore.kernel.org/virtualization/3364adfd-1eb7-8bce-41f9-bfe5473f1f2e@oracle.com/
>>>>    Otherwise
>>>> we may break old userspace.
>>>>
>>>> Thanks
>>>>
>>>>> +       vhost_vdpa_reset_map(v, asid);
>>>>>           kfree(as);
>>>>>
>>>>>           return 0;
>>>>> --
>>>>> 1.8.3.1
>>>>>


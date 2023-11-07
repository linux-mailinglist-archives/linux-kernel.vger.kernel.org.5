Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1A97E4B50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343517AbjKGWBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbjKGWAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFF31999
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:42 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJWZ5029132;
        Tue, 7 Nov 2023 21:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=vSq2w4QcKk2oa0vFIKRTjErZNNQUOLA4d8keGVC8hug=;
 b=kjt6N/u/GSd/CAy+1rGUm7vGAXX9jpl2REIFKXZmhPR2W8FEFy8Ukw+L9dMGa8E1wMIr
 YTmCinzbsmh0Q8TsfqVXZ1nlvn/3vv2byPDRTxN0xdp48W6NuWO407qk7ZhmWzOhkkgD
 ZGqSnaschnKa5k20u4DdItCdq4x2KnuCu+bTOjzWSTPIFjKJSl6YS11ZoyAt+o+hoCet
 R2Uo8iWzrU5ym+hz58GFKA0EZc2GgTyDPWKVwny+qxHaB3/yoDX0xbR8td/XekdL0B/f
 X+cvcw/1SmYLptfTJj6/ZPaICXkYvMe63ZddPsf/+fqMiA2AwlNCWacrcEezSxqE/7zZ Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w230294-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIrHc003903;
        Tue, 7 Nov 2023 21:58:18 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshdn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrjBKzDS9/JX2j7Nw9xZ0bFD3SdTrqnX16XGY4Quub0ONrafej3nix4U2/LkTUf8fDPUdVRYq1gFrVA+JjIvqoXMoevwRjyowcb2gxQWXn81nL4MXdcBVZ4bGeeootn9udjerOYJz5iNVr5W6KssKb1nhx8HfzrsRDUUywMjQB7gdcPpF7o7CBcCYXbv5QRtVmFuKRnNzKQuI596g96VUnHJ5QVi+zkEOGo+6AvlOVmx8EzI35NNZSYo9IoCXD1EBXo9LjEOtnrd1APNte4NqOTUm25X4rQjrtiZxRsJFmk3O2WHRuUSmDDPhijY6kOASj91FKbXQ5hymm7ZaPIp5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSq2w4QcKk2oa0vFIKRTjErZNNQUOLA4d8keGVC8hug=;
 b=kc1vB/9UMSZfp2ODUqcXNBZKhM58pR6iM4w5OLa6kp2hY5OsUzfnQm6UykzQujDPbCWZV472C4WhnIo2Ukkh4LM1WMYy4ChaXp/KxS4FnPEZAvNzwrSnBIoSZEemLACu8CecyDnVZh3URMOo4dH9DPhKfw1gU+qOl5hYK8XCp2qph1S3bbB8pQ27BX1TvlaShWwRGwRvPbT2A0SNlhWbsuQYQa7SWypFst89XQ3Et3v2g4ncaBNZgNWkLhj8asmAESU7y2vKffiE/0Xq+PFZSK/uT7f8sbw8dWaLW2nu22fz3+hJIJ0BbdhVlH/GMXvG8+2TSWX2fukc77Q/SIpwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSq2w4QcKk2oa0vFIKRTjErZNNQUOLA4d8keGVC8hug=;
 b=zIiDs6bflFicy6PIZupH81vvGvVMAIXKPksDRtnW1WcappqQrIEk57UxextKEhr9vAkKetGf4kbrohtUGTjjznIjOfX4m0mam1qHC1KujhqFJuNJcglKUIOXpMEycQbpxEs5gRKW9vxDq2FRqKDgQevIOHnZ6rYuLlcAKaLvsoc=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7651.namprd10.prod.outlook.com (2603:10b6:930:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 7 Nov
 2023 21:57:57 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:57:57 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@ACULAB.COM, richard@nod.at, mjguzik@gmail.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC PATCH 05/86] Revert "kcsan: Use preemption model accessors"
Date:   Tue,  7 Nov 2023 13:56:51 -0800
Message-Id: <20231107215742.363031-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: d672b789-0ac2-4f29-c07e-08dbdfdc9a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oIe3KAHxxpSgFGStGVa0CQfxKsFQxbWW77uCIotdUQQ7kBltZ7+S+dKdmwfHDuyYxXhJRffU3ewhjSsh0XbSyxy3W14AmPjKfTgUaMpleN39pZjK6w88NerLhXGYjT1Ig9m0C9nj48gK+sFV9N2pNzTzn1WC904lcdvnyerp5AN7n9vlExETPZit8cs76ZeZYhhfpdA5T2rKhQwbCOEvByXVUlNoqXyKh1kLcMSVGy6rZ15rmCp/08LbPeSSjFVQMh1iVHqrjPxo4f+8kofoST3MFt1K7qotKubnLtrzhUSwz3GRfuk8GBsrxoiReMSOcy75SiLMtSTmMNk1vGiccPUu6/bndp9X/hRsihlOwKJU5+QN8gxeDHSM32uKOrMHmImULI7QxQPyYw01uSit8CRNNcU+cFesV9PgAToE0fhGSQeAQLcRUMoDpl5Zj8jGrLYYfATtFD5lusOBYSfuxfVZE3fb+bmhHZaLBAcsOdKcDBA6qeFl1Rtwyz0ry2SOk5FEtcIY5Gu9K/uXPvlRYmJNBE6QwpqqUJLx7MJOqL3/BHSq8MOQxy9Vucan1r8c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(41300700001)(66556008)(66946007)(83380400001)(7406005)(7416002)(66476007)(316002)(478600001)(8676002)(6486002)(2906002)(6666004)(5660300002)(4326008)(8936002)(6506007)(6512007)(26005)(1076003)(38100700002)(2616005)(107886003)(86362001)(103116003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RfqHHp4EaSw4SVoPQYHyQj5rDEafvjLCABhjeiQibaEFGT4G4PimsYU77h0p?=
 =?us-ascii?Q?UdneFD9QGS345Mm7Cpfd94JyuJ8lrRQHrZC7dODC18gnHrMiWPE4h0ACunFn?=
 =?us-ascii?Q?WD9c1qmJG1iV4ApHSpv+WTHXIg38RVhoZviTmfdtnPjDk2a4aZ15A1K17bei?=
 =?us-ascii?Q?npZ8/EKtCyKVfkLvi/9zY1fbGaDIB7wIso5faxwMVyolRTFADPulXENVp+jI?=
 =?us-ascii?Q?y+zt6tKeFqQFA6vLl+UOYqjq2DX6rcob7iOwEf0QnePZiKuVawH8MZSeMwzL?=
 =?us-ascii?Q?MArUaFvD8ZO0hhEPZCtR6Arp/aOzS0sL8ADs2SSAy3NaUqnQo6/FY+MmdnRF?=
 =?us-ascii?Q?xTHAwid8xUFT+i3JLF8JvkQg6PrL35TWLT4IC9aQlU3RC4pStvYezpLnG0sm?=
 =?us-ascii?Q?hUnXl8EJkEhDrG1nIyzJ2t2KSe4/kpE1IQM/wcf/2dIt2mLWsceaf0sgTDWc?=
 =?us-ascii?Q?u/jHIK5Yjg94ppyoqs+Fdfm60g8VsKsYcOMTBjBWJO0DILVBVVwMExdTpuwG?=
 =?us-ascii?Q?2JppuKWOBQyQhqRlHLscvatOi+3Qxh95ucsP9sryW4Gan+I6ZE9mu7MPna83?=
 =?us-ascii?Q?tXVtI+2EDCj9tzXY4yUj88OluiFI87TH+LXCAXC6lBsJxXi38D3gyJXoiUm5?=
 =?us-ascii?Q?Tp6WtHj6D4Utf4RdJCDJcUwCuhNoCRlRWqZHSzvyaFOn6aYd3IK95zG4eWH+?=
 =?us-ascii?Q?HAqjBsywJE5xRN3YWSXN78+No1+SiNFV7Ksof7d+hNKbe9q28Cvh8Y2qJW0+?=
 =?us-ascii?Q?Oq9g3I79DjtrbnClaeTeFDRfUR2jXj+sF1SptMAusnSx39YG1V4Y2Tmw5Wex?=
 =?us-ascii?Q?88VaMVtOAS/BgkAKaPAi87f+9GFkN6XBLGVsnxaRAhyRKHdz4mX8dt8h8U/9?=
 =?us-ascii?Q?jxU6Tl6WDnQK2cLlJUicNjxgYIWQ2XXkGkPwYsj6301ZTQ+ZAKdqQ4/mon5/?=
 =?us-ascii?Q?Vd3sSGpW9WlrVUeNqmHzoIua76sglScvb9p3cNco6EpAPZ+cqqYbqE4sEVNg?=
 =?us-ascii?Q?K9gTKpVCyAwUVism1/H1ZSguhOJAjS4G58Ou8UBbea1o4RgYBQgv1ce1a6Dp?=
 =?us-ascii?Q?UNQv1iRZu32V8wr9HFzH5WI8Dq5ek9tk1M/hcRj+Ouz1uc7Bc2iAvrukZJfX?=
 =?us-ascii?Q?2RP80ZHG+UG/iu61s/wu9U9I8eNqveBVrMWQUT25r3oGq77DJR6zhcyWtwGG?=
 =?us-ascii?Q?Pi3zmO0eL+vuVguc8DUJepDK6sYuFs9awrBFBpUoCcIOD6IKG1Rp9ti6r3xg?=
 =?us-ascii?Q?1fHGX+qdLGxvTJCgwcQW9dDKnQBpmFeJ/dfXYDfHj/x2EYMZNwYp4CLCtGVk?=
 =?us-ascii?Q?JMJWVGKEJffV4R9Zy+HedfgqfUaxvvQyDd/tPRZ2EiqVmOdVOFS4vqmVOG6G?=
 =?us-ascii?Q?Lb5jpWCvEey2AVvdXJKG/jTJ6siOREBx2cp6SotPnpKWE5nIGEBrMLkT28Hl?=
 =?us-ascii?Q?Q9Khu0EXmkf5ssWaVXNBArmtV2upaifFh/0nClKozbVVB53HEnsz+IBlIif4?=
 =?us-ascii?Q?5FMIeS6VtEhLAPxQN3IV1hzC8N3//8k9z80wlHkioX4zC02jdWR5ak87PDEv?=
 =?us-ascii?Q?msFy4glHSsqe6QAAju7p9Kp0KpUU6l1ZTygwdCI7MuQicNvHkOMAY+MWPKXA?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?inwt31KNo4tNVjh+UzzZ0oWgjMCdm2zjJ7Dw7cYS6m+kfQ8oLkBwrwe/yOol?=
 =?us-ascii?Q?Rmtl3jiBElKZoLYxxvCizemqq0AQzZEta85SG9mKo/Dn8zqKRRRkp80vgdaN?=
 =?us-ascii?Q?WEseXf7VvXdJsrOnt5J27GCVOyaYkJ/PfCB0jG2V+oaHKQUO+vN10of01cY1?=
 =?us-ascii?Q?l3dDW65jH+E8tBPtYSyRoYji0eUFq4B04euUvk+ZhgUzz8kVpl+SbPlVfdyE?=
 =?us-ascii?Q?lFpVQbQx4s2JWsjgsIK2PtNuGIakfdfdPxoTeH9cqdsLL+ATmcEJ9D0hVVVs?=
 =?us-ascii?Q?jrzeWcIS47YbLCZherR/brA4eWBzTdQBnUQOUThBh27ZfkI0SVlSzkbgarj1?=
 =?us-ascii?Q?5q7Mfk9jU2wK1ONFEeuefcywl6dhDTbFuu73zFPZiK5BQkQE51yk0nkP4Zs8?=
 =?us-ascii?Q?2UBhpkcQpCtOkNyMgM541b9/BW1455VN/vAOgKxqOlNHOxxYRRqY6r2q1m5S?=
 =?us-ascii?Q?YKFitqlry+IpEGZB5GxazDtKUBvrA3aA8+FdCu2c+OLrXIpxutQ//Gtlk/jW?=
 =?us-ascii?Q?ciJgUNXI9IkACDvRBD1DYppDBEx1LB0uIEKAdA/ToKPdtOr5pwHIAEaMe36F?=
 =?us-ascii?Q?wMIyR7W6SAL9Ny69iDCTi2dVbOZImj0Dw+eR5DRmziLKwCef3vzIAX8N6s54?=
 =?us-ascii?Q?4o2YhJjXebdfSstO0MWF4psP3fwn+jCBwiXnQ5enBSaBa7PvZDJQfIbGlXwb?=
 =?us-ascii?Q?LvDvxnnOp24xwfVcgPG+Sz1HnV/GOiI2DZZf5OhLp2BWMTOVX/dQJXApi0UY?=
 =?us-ascii?Q?MquBcJhSEcSWdhKh7KnnlXVIwrGVY5/1YEgSjItxrY+nWUvIHr2Q7naxFjXe?=
 =?us-ascii?Q?dCNxPyrngUHVbf8dIEz80Zxf1qLn/kC32ccm9PFHChaEqJXsisIybfFG2hlI?=
 =?us-ascii?Q?660dlN7woefITSamVPPGz8ZFS0+Re3tFVSb3SeNHj2TJLtx8qw8uGcKtT+ij?=
 =?us-ascii?Q?UngMysKexNCwm6+/7CAJ6xOUXL92Nd+1tVEP85xNZxVgdY6RUYM1VJ0/uQJg?=
 =?us-ascii?Q?QQ7NQQMKyplIruJkZ70Ubz+PQkJHqWGSMLwA5QVdGERDRwuTYPbhjrGIXfa0?=
 =?us-ascii?Q?WgaXza5KCvKc/uKSWKXwhhehHWDQCNr8ihrAgDj3RMB0tO0MAHhx17i6wU20?=
 =?us-ascii?Q?i/lRSry9GzpYEyMvBPfFegZySOQ74hZkPRwUqx2kB8UDH5GCRU7ck8FyJQ4W?=
 =?us-ascii?Q?/l+6+CH51ubKEoeOjlp7adUht2nUQdWfmP+h2bDh6+HBAi3Y7w+P53aGcMvM?=
 =?us-ascii?Q?6b7vHfPXAlj+A/OoO5pq/d7XKQEIEfUCjz3Leb2KcrKvJipjddoejZSJdUU5?=
 =?us-ascii?Q?ho/c4SvkjX1ZhGfShsUPp9FEjngEg0kdujUOa6shQu0M61JrEFSW4/DuUAEo?=
 =?us-ascii?Q?HkRt4E06BEtF556eYX/D4qTqwmNz3eYwzqXiRGK3H3vOnEMMEZTvGafkTcPo?=
 =?us-ascii?Q?S1XKDv81nb7Fs+c8h1Kq1Q+lvfUyY6Eqj0yI2TEGRAIt6ykWbghnlElr9u0w?=
 =?us-ascii?Q?Y8OjZ8PqTmdUJ0hAH8EGOCAXvBvzCbrw39kRLdpSZwnLrdpVlOptx/BYwg?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d672b789-0ac2-4f29-c07e-08dbdfdc9a05
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:57:57.4328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRYPTIh7c0iyYfpXRYbmnKlUqvcYTaiueLVggbEFqA2lszOmT0/6x9hrf41lktXaHaqto9tk3WlgK34NTTptR4IW8O/6cT6BuX5WOe6IY+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-GUID: HuiwYIi76RmiFcWCATsnlA7jVoushHdD
X-Proofpoint-ORIG-GUID: HuiwYIi76RmiFcWCATsnlA7jVoushHdD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5693fa74f98afed5421ac0165e9e9291bde7d9e1.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/kcsan/kcsan_test.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index 0ddbdab5903d..6f46fd7998ce 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1385,14 +1385,13 @@ static const void *nthreads_gen_params(const void *prev, char *desc)
 	else
 		nthreads *= 2;
 
-	if (!preempt_model_preemptible() ||
-	    !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT) || !IS_ENABLED(CONFIG_KCSAN_INTERRUPT_WATCHER)) {
 		/*
 		 * Without any preemption, keep 2 CPUs free for other tasks, one
 		 * of which is the main test case function checking for
 		 * completion or failure.
 		 */
-		const long min_unused_cpus = preempt_model_none() ? 2 : 0;
+		const long min_unused_cpus = IS_ENABLED(CONFIG_PREEMPT_NONE) ? 2 : 0;
 		const long min_required_cpus = 2 + min_unused_cpus;
 
 		if (num_online_cpus() < min_required_cpus) {
-- 
2.31.1


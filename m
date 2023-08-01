Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616EC76AB22
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 10:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjHAIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 04:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjHAIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 04:34:03 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93758E4E;
        Tue,  1 Aug 2023 01:34:02 -0700 (PDT)
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37143AMx031557;
        Tue, 1 Aug 2023 01:33:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=btIkPl2FqYAVt5F4X2KJwSaP+DujySar2nY/wTtzspw=;
 b=EDB7RIPZkO3kv82UujTzAP/Rxy1lKnLtfUBHhrPeIS422ROBoM8s/fGtwVadOVZiNwBl
 UcxgXYn54F0iUEoy1EU2g2Xr3VNj4TWY77ZOo+iDn0d1F0s0eXnLLbfvZWWPhDwHA51W
 gzJMlCCGuqWBJj4xF6NGAXvATUJmvmCzfD9NlCWYrOkNAZJc6R5W4ZhDXjIwCnJwl3G2
 KZLgaJpOtd7OeNEbq73V7j2P3hJ7lW14tgVcvghbNziPddNsk+GJsGtxrAtEv92Mj//l
 e2pWeUopfccY5/1L74nM/d0UCZXmM2wBdn3l4HGaVu1V8CxjFgmdQXCLJTPpz4ZnVGde zw== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3s5213jskh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 01:33:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1690878821; bh=btIkPl2FqYAVt5F4X2KJwSaP+DujySar2nY/wTtzspw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=G+69YoFs4aOukF3lgk+jnnqjk06ranFGM6lFjPsO0lOz2A5wqxiZGPJHKquSIxYuK
         URFTaxyJmJ7qmbMUTy63oK9VajwsDgGMhsFrjJSbgrHcz3vkMRiBn4kz0WaBAcmiHz
         BfgSOK/JujmlfdhzpaBHVSR3GP7wvNtM3eywwuIzRfB/H3yC2hR9A7QIrfg7inasJU
         wPdQkHbj8DKBg9Daq5tldvDvBjXvBCqWXsoj4WwwTLzfzwb+277XsHeFqG36qGQ+Oa
         QmltVey3w1nYlnixbmNVsQU7HNeuYmAY1nWtwK2dmtxTExdZrq+KPLZrC0ITlPkCVF
         uGXt4bvx978Jw==
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BD89740121;
        Tue,  1 Aug 2023 08:33:40 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4918FA009C;
        Tue,  1 Aug 2023 08:33:39 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=KKGGQDc0;
        dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 37C29401E5;
        Tue,  1 Aug 2023 08:33:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp4Pqhf6RePdDbg9cFA2JwJMZy5xq18yrbRY7MNMGVz6P6949WvNvkAxVJNpbehzcLaxu87yxKfp94aXfUnH55OR/o+6zYBzs0Q1//xRWZg3CkOx98X+/No8Gvm6jJuxCJFo0by589NrBlTDTZMIF0YcbcP6fLuwjfRjQ4Ot4CN+j63eX86lKVigHgHg5f9ZU/NuJb39h5gptY1wC12jR3F6DrEnkSEVtje8c7LlClOycdwWXuyS8iWrEhV/Yj14kV8yGGfPzZHvk1TVpRzw8FdDgF3Y3mQW4BdeAJT2IfNSZVIoNdXztVmDSiJo5ZuFbQb5dZWDaQmiEPwrAhjUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btIkPl2FqYAVt5F4X2KJwSaP+DujySar2nY/wTtzspw=;
 b=kgn33ElYBVScP3WahCiVFp5hNIYw6SexylzfS5ZCUhc6hAqQYqc/bfp4YFBZuODHH9GvRfa2TBQuFFMl04DvMZjUaZBhP7qPkchRkag8e9RgK2XVtTPVE3Wa3u+cNxxe1KnP3IDoEQPkrINn0ZyN/FkxbDjKro/3Px1H6XZ+lOeRMsHtwkKx//brwuqWlFTedFnfMcAZWceTfgmeQMug0FUPX4TAa5UDHDOdEsOAwYWP1cgf2c8tLBCCQHcjMVaU2Xe/GWEK88t7xrIRPJsdQcZm+iMaCD3xqKoOp5/TdE2/r7pYBaJAh7hokaMvtyRxAZQ0vismssGCqNOqfhmMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btIkPl2FqYAVt5F4X2KJwSaP+DujySar2nY/wTtzspw=;
 b=KKGGQDc08N7GaibVbT1Enkh2zxO+MTIzxYSQEAIdAoLlTuNonGM7jiINwLm4ujdSVKu+LWsYg245G0yGkZg8iSDbh4kfM1v1Po6+b3GpLu1L6xUIvIvZBkXZF/iH0k7Rdlma7MlRvKeYLVPgW/4j40wbBrFq5ljIiKS81NPpGMw=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 MN0PR12MB6199.namprd12.prod.outlook.com (2603:10b6:208:3c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 08:33:33 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6631.042; Tue, 1 Aug 2023
 08:33:33 +0000
X-SNPS-Relay: synopsys.com
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH net-next] net: stmmac: XGMAC support for mdio C22 addr > 3
Thread-Topic: [PATCH net-next] net: stmmac: XGMAC support for mdio C22 addr >
 3
Thread-Index: AQHZw6VNhFeedRnanE6sl73uEwTuj6/VHiog
Date:   Tue, 1 Aug 2023 08:33:33 +0000
Message-ID: <DM4PR12MB50885E30784445BCA36B02A4D30AA@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <20230731115041.13893-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230731115041.13893-1-rohan.g.thomas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTE2Zjg0YmU0LTMwNDYtMTFlZS04NjJkLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFwxNmY4NGJlNi0zMDQ2LTExZWUtODYyZC0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9IjUyOSIgdD0iMTMzMzUzNTI0MDk2Mzc5?=
 =?us-ascii?Q?MDIwIiBoPSJONVNpZi8zOTZiNDhtendzQXBkNmh3Mmw5eEk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUNN?=
 =?us-ascii?Q?cUUvWlVzVFpBUmJzcUJYYTh2SURGdXlvRmRyeThnTU5BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFBR0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQUZWYVdwQUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCdEFH?=
 =?us-ascii?Q?a0FZd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lB?=
 =?us-ascii?Q?YndCMUFHNEFaQUJ5QUhrQVh3QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpB?=
 =?us-ascii?Q?SFFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFl?=
 =?us-ascii?Q?UUJmQUhBQVlRQnlBSFFBYmdCbEFISUFjd0JmQUhRQWN3QnRBR01BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJtQUc4QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRB?=
 =?us-ascii?Q?QnVBR1VBY2dCekFGOEFkUUJ0QUdNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?Y0FkQUJ6QUY4QWNBQnlBRzhBWkFCMUFHTUFkQUJmQUhRQWNnQmhBR2tBYmdC?=
 =?us-ascii?Q?cEFHNEFad0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBY3dCaEFHd0FaUUJ6QUY4?=
 =?us-ascii?Q?QVlRQmpBR01BYndCMUFHNEFkQUJmQUhBQWJBQmhBRzRBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpBR0VBYkFCbEFI?=
 =?us-ascii?Q?TUFYd0J4QUhVQWJ3QjBBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUhNQWJnQndBSE1BWHdCc0FHa0FZd0JsQUc0?=
 =?us-ascii?Q?QWN3QmxBRjhBZEFCbEFISUFiUUJmQURFQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdVQVh3QjBBR1VB?=
 =?us-ascii?Q?Y2dCdEFGOEFjd0IwQUhVQVpBQmxBRzRBZEFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCMkFHY0FYd0Jy?=
 =?us-ascii?Q?QUdVQWVRQjNBRzhBY2dCa0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|MN0PR12MB6199:EE_
x-ms-office365-filtering-correlation-id: 437053ce-9d3b-449b-f729-08db9269fe0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bawPLZpaQNuWJ4XaswsWxPIgr5G646bWi7oVFPzVIjc3WGhGjCkT/mdSgJENTwEwUn/nu64YjdenqACKMF0kQQ5ns6ZESmtZaGDSKL0koPP8clcclKD+rjSuouec4NOGhgX6hrIIfVg4SY/Ppc6rFhMTNAzx8+SbZlDZJADZqKQQOnkWzh0s+QWBJAtegwafjQnpskRskzwXSLZiQ15TmaStWuzzTUYV7O1kJ5ec5MsBcfmS0psAP6FVmZYa1K/j4wHiRG1vqYgIZgmNJqNt8c+ECrgy4BO6Blwdsck84ib8j5mSRNFAWCXMOuTSoAnudWd9T8Zazz3QQSuPTUuGvxVqV726+6XZNWneYURf/7/0XnBEaXaOBoUCmcYfpMGuP2S4W52aCHQaBCAffUrlHehS66WzBc1h0BfEyVEE1IbutByFt9XdS6YXlDFr2aJOdNXbOlFkriQ40l9vByavDFF+F9Gffrkwbqjx91mqsEhZ48aju1zIDcW4bJRz6ibr0bfZXVeAKldwKvug7H3jIfJMJZQaH73ub08szJtQoQSvC3GAhqK0HiKJ5HElNkwZ0xD/t7b4zhsqwRWKH8FUwh+6i/8C4U4qsbCrBgpVPcYCaSpAYjDhCUnv+kM7hjWs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199021)(9686003)(71200400001)(7696005)(33656002)(86362001)(38070700005)(122000001)(186003)(38100700002)(26005)(6506007)(107886003)(55016003)(52536014)(5660300002)(66476007)(7416002)(41300700001)(8676002)(8936002)(76116006)(66946007)(2906002)(66446008)(64756008)(4744005)(316002)(66556008)(478600001)(4326008)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eRswTcua++nd80gZ1VoIj28M1Krll4oYNrUfj0uKAviUm77MbCIsMbeQc1uM?=
 =?us-ascii?Q?0BMLOXixpjcyRnbLyBPWdLXZpCyZ7S44TnUQ94as6KZ+Aeoq+bjXQt/Cv+KL?=
 =?us-ascii?Q?Yv0pkt+9WDLa1TFeM/pwB4WP2BB81odF5d1uI/fZZzYOA3SFKnJPOo5SJDSC?=
 =?us-ascii?Q?Yh/oo9zvWJ6c1wgw87aqPZiazuS5UO7CW/NiiEZsSmzEU52Uv41AQ+FtDuk1?=
 =?us-ascii?Q?ws9WWi368/S9R7gD4pxHSqLlpE3iW8QC9DU0A65JXJrJG7nF05HRat/+ri7j?=
 =?us-ascii?Q?ilXqIaD9QOEtpCCFHgbkaPtybl9J3g6EntQ6rCh15NUTassHGeVrYUFqcW9E?=
 =?us-ascii?Q?ghII/66NN4/4TCDyOkbXWj/9eaXlen2FErLWZ3SK/N/VAT63pJ6VoA/UQmK9?=
 =?us-ascii?Q?BGAHAllJ6a2/ZldOLmncSyVlDHfxE6aH4kA9chK8t6uC06oVMZpA+rUZwQyy?=
 =?us-ascii?Q?MJoSPs8Ds1JUGjn+mjXa15vcwkfAA00h91sx3PdYepbu4Vmf4ViHVmHO30dL?=
 =?us-ascii?Q?YYErQH0qkeljHLAAsYNmZfWptg0M++rdJ03gT3q0MmUrDHleztw+V+Ee61Lu?=
 =?us-ascii?Q?0gSqxLAoupmPCre8xtc1C2VY8Sg2YjcE43vIEdG4b/zCrqyClSaNQVu3k263?=
 =?us-ascii?Q?+DKbtp52JFpWF1uIA4aHWOx33nGkAwPI+vNadmbJXsmfL8ayX1b0TfQlBTGj?=
 =?us-ascii?Q?HBmiKE2D9FPePa0r2LKRtVNzfbz0/McdmkxSGvsPTlDIiPdZ/9++6BkLoc2n?=
 =?us-ascii?Q?zYN69VtTbjJ0MPGwbnGax2lKvw7qdsWzMzgCNPZ17dryNIVKp0oFD40Wl/p8?=
 =?us-ascii?Q?XldiIBK8wybfmP6sf4raiZw3ClHqlc8dald3EyvsXORmK9P7hdwL3HueL/iM?=
 =?us-ascii?Q?QYwDghBVaWRnI5DoLDHcUgPgaTXBz/OWQYKOj8v/Rcwe623/ocHBl1Ab35yr?=
 =?us-ascii?Q?zAuI4ovz6lL8c8+e4S+LMHTTW3JdJqEDvFQQ5jNpZPJ0xZcxXk353nEJdNDP?=
 =?us-ascii?Q?QyQVKR52YuLkC00zgvTOSAlESKEaSjeWzAAKbL0Fp3dpcQheNRLhUszKajFQ?=
 =?us-ascii?Q?wTSamQ3hri6zCdtoFeYN7ggDkNBCCcCxkbfMl6mgv3TSpGgKjoVCTeVLO7Ql?=
 =?us-ascii?Q?+F/+6Mn5TAoo5k4WxKAZuYSdx5n82d0gjd3ER6bk78tNfvgZR0+Q0baXtBh2?=
 =?us-ascii?Q?FLUBqY6T0eFchZp+rEQvhhSPns/DjYz8AL1PkuJlPXWSnujkNqQRgqZtGoyw?=
 =?us-ascii?Q?Pj8Af+x28IoITEa7zBugRlqBC+GZ9Qj5SvkN3A4X4xCdtsjxhzrgSINhZTDq?=
 =?us-ascii?Q?95ilQHwwXWWrNrZr/dAvZbhOj6Vdu+fgL+QyRLhOR+IBYSsFXLW2N3tQSIU9?=
 =?us-ascii?Q?HflGSYkJg6wfHEzQIdPSMgMWSorZ1NaTzRRCRKYaKQxaX4rm+jA5ruHXaR+z?=
 =?us-ascii?Q?R98z6ZsMNT/Xr/agR9xa6P6o5YCrXfZot7oBY779zsmvFZJOR+T238KMqCt9?=
 =?us-ascii?Q?LUi3opAj2pHDFgH3ByNhRFN6jkAB4ct4MJLxyTHUguz7tQpwoQG3r7NaxhEh?=
 =?us-ascii?Q?aCK9i1qgUq2onzZ7q+vSNVXSDLFmZARMpz8IegNM?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Gov/pjX2XE/RBVs5Nq8/xQfZVxrEap0VzMnJIStLZFVTyPlPgxNQumgsAP4S?=
 =?us-ascii?Q?22scyh5/1K3AmyZz4gL9ADbU75H2gYyXnGYcACAmJCEt6cvM1ITZ7o0F8MY9?=
 =?us-ascii?Q?np42o1kmMPiAPS5G2lPzERP/6a3tH+SzatIpDlse27dIuL/mmbts+rveMdBY?=
 =?us-ascii?Q?GWnSCuxepqdYi866bRppksqgDEm52lVGSdRtPkcqJvXSuJqEqqKLzqbOYQOG?=
 =?us-ascii?Q?tgJRawbElmaq/FwzP7ZMJuNNTnkjlkY1Y8iQzj/60Xquv2qwmboBwUQ5pieg?=
 =?us-ascii?Q?R21V7FUJHAd9Mu8yzuWYlcFwmO3RQDnoo33lsLl7LzJ637Mk23RcCTlDDeMD?=
 =?us-ascii?Q?OjB8LUXa2Ti/wAZLT3A/ug8bqrDRqbZgJzTznOgJiaN7+0ytApsNebaPrNsT?=
 =?us-ascii?Q?v6aYbVeIUct64r3eS3z1a1tMfOxrASJkrZfYOmVZC8IDdZHMouRHyOx9soac?=
 =?us-ascii?Q?BtIkm0VRg0cFAMj7T5PWmXHC42NLdBv6o7+hwk/wnAzcwq2NWCtcU5DhPYD2?=
 =?us-ascii?Q?d3Rn6a48N98+8npWRlCgkovQPETjdfwAQzkhdlFxbklGYOuuUXVpe/6rUJte?=
 =?us-ascii?Q?MCZeSBuL4PMtpnuHlLXO+l0G5nCuAb3Q1eRUImj+t2FmpNpJAIUmJmRptsJ1?=
 =?us-ascii?Q?x1ecCAUGxooTjN+8GtM7z9K/8eNBMQOkgBvLn0zRnXZYAg8CaDz+CIW2hqJC?=
 =?us-ascii?Q?kRhD9uM5VjA9gfQ6ITF9SOrD517KuHnnB3jeBE21qo3CNCvY2zOTvPm+4b9x?=
 =?us-ascii?Q?j8LjJ4q22H7H+vKHlqCrNCYhxv41mqKrBEH5mBE+f1/NHxqBdIKG53qHygY5?=
 =?us-ascii?Q?ynlgt1GNu1jwq9+l/P1qwZf1WTH771Pz3HKzoCwqGgb7u1gv3IHs4k+ANdez?=
 =?us-ascii?Q?dVwuQfYQTbk+xBL845hrxAc8/cycCKphFzzsOtnUdGnZ9Q7XvaR6vMdMyPN7?=
 =?us-ascii?Q?ByV4rNAI5Hnj4UHESkmSEvcDjuOsFJTuiutzOQ9ukLJp8Sq1kx2dKUWMwiuz?=
 =?us-ascii?Q?3zOpHc0etWUHag4VC+U6g7SBN3416JET7vvwBt7fl86A6we8bY7HDJg0iZZX?=
 =?us-ascii?Q?DaqrkUWgHaYdLiWdTc9XC+tyPAgl9+skfFRwtXklOXbAZ2ILcQr9Ie1s/Np+?=
 =?us-ascii?Q?h22trofZPufa+wwF38FnZrNXErYw/xXt4A=3D=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437053ce-9d3b-449b-f729-08db9269fe0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2023 08:33:33.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0gqbNy61EZkBjakzx6yAjhVfKmIRB5ltlCbUQ7fXH1CKP/UE14UijtxdBSxbT8LJFkFCCDR2vSiaHuADd+lWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6199
X-Proofpoint-GUID: E4eN1z2Ch9hJ3qGAHZ0Aqnh-7e7_LoPU
X-Proofpoint-ORIG-GUID: E4eN1z2Ch9hJ3qGAHZ0Aqnh-7e7_LoPU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_03,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010077
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>
Date: Mon, Jul 31, 2023 at 12:50:41

> For XGMAC versions < 2.2 number of supported mdio C22 addresses is
> restricted to 3. From XGMAC version 2.2 there are no restrictions on
> the C22 addresses, it supports all valid mdio addresses(0 to 31).
>=20
> Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>

Acked-by: Jose Abreu <Jose.Abreu@synopsys.com>

Thanks,
Jose

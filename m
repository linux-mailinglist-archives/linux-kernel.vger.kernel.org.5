Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BB577BE5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjHNQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjHNQse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:48:34 -0400
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8831E61;
        Mon, 14 Aug 2023 09:48:33 -0700 (PDT)
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
        by mx0b-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EGgHOP018854;
        Mon, 14 Aug 2023 09:48:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=HwxzYsCtjaE7XP485ucNaOHfn9nTfba72axQ/tK6zrw=;
 b=W7ZvzRueBVqZQaDvh16Nr7J2QuO7OGudWp9IYsVxyrhLTZy6KT3P1yS1jmAvu1dyk++x
 vVSKp5/CKc7JNOKl8bEOJ4ny+HXk/AMhUiBHiJZesXjyWSfUtQgv6Yf5wdR1cdETeWJE
 /djBFggRTYExRKMj/rMlvazHM0lYmJ0E4mDlM00nVOGNFx6chaFxFDQzCp3qCstM8+uw
 VfidIu01bp6srUKkAyPrgEbv2lRmkh3pu/1KlacElHUSyrhMPCwOYXTDciYP2w+5wE+B
 dyVGj3WWQvmabpVuwPs7FOsAJROb2Ccu5MpF21UDfNwu4NQs0dXKmwGXUBYOuyBN9SjY LQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3se8qd1kqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 09:48:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692031680; bh=xeHOZweB+mxqoGp4kq3jGqy0PXf/0zF9aMJK0HO+h8c=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=OwuqpDrksiJ83ufKfZ1jYLfQMJYgbYE0WV/Tz2TKVO9wizougui8AYcqkB4kp0+2g
         F4TXKw6cAjDG6MeuY5SkfLnIoYZtnHfcw6aJp2aKVTYfCrw6mGbF0xNcACrSXHDIqJ
         32QpS7wHYSUEHnTCFMKqWUwWcV7lR7Wx0d+Vt12qqwJhvY1w8xSZZ/uX09j46qMfHj
         Xt3PVQFg2TFAPTnf5aR4mx8hH8RLmzQdDUWEMEMUWtz9HXqaxIBEjL1pnS/x7Kykzp
         Stf1cs32ki2B/9yBi7ZLTPJeFjc1taU7d1MHgdrbQgtxUAy89dnw/a7sGb1dcWocRx
         NtddbPWpc2YYQ==
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 78B1D40149;
        Mon, 14 Aug 2023 16:47:58 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id BCB51A008A;
        Mon, 14 Aug 2023 16:47:56 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=oURVL+Xz;
        dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id C7D3B40169;
        Mon, 14 Aug 2023 16:47:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1f1UFQNi98s6UN3NazIXkpQ6VWXaOEyYBp9Uwf/NCncWjYepAmC3p45QOtyFpkvC/XF+ANOEIJ0IxIS4IFFeOlyAHoTrodPSZr9Dh2QNLp5E5zpB8rXSjnvpVxz0iZbRFsG1mpHjvm/9IaIeqGFyafhVqQ4hERfjXgW5Z0rMid76xgphb57sDQbwNYnsZfOr0/hsB+PXrhCEtrZV09fWpT1hZqT5BTiLunEtb/wCrf0z4D4gj+SwMSXOZbWS9MZzTLI1UbwwUYwfZjPrVk5kr8vpw2nPf+n0VTzQ5bLtT72saRLvqZVKS85Po1RGzA74HSQtPnUOIE2NpogrOJCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwxzYsCtjaE7XP485ucNaOHfn9nTfba72axQ/tK6zrw=;
 b=QND1pcGdweG8vF9b9YSlwIWJv6AMF5pYJed6REdAX0u6aGJVOB+kaCBvH/evM02L1AR8EpKHg28zdbHetHKMQRfbh5/E97FU1HX6UqCnmI5BzUqLn1wGuILLbuSjY4ZMgrmREhNqPPB7MvtiXaXLsQEkJPC6VS3SZzQcvKD/23E0CWfYJM/pJPIfleJQ5S6+OmekarhaHacNlz/PNuvqQS9VBcrv+ofD6vYTDKwaTRCK0ONW8B0HR+BhXSqIuZ71obtZBkTPi/GaSp6AMEOPFB3PhZEAYx3oUAeqmbFXyVKTjOC9Ixx9iFB/RsJI2pWxacQp3EtieNnT1aj70I7SwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwxzYsCtjaE7XP485ucNaOHfn9nTfba72axQ/tK6zrw=;
 b=oURVL+Xz6pFj/1cAjd81zUWKLdbspKiNQhZ88XpqsnGxyRmCiCR4tR6NETcnC2BAZkkIyosnm0fJtfw11+6s82Xgk8s+QLBHxK0PvFyUq2B9/KCPGNlyJ265EocW11hTCuZEfWzx7ePZO6L5VgRMlgBGioz69bSVhOPOV9GFM5o=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.24; Mon, 14 Aug 2023 16:47:48 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 16:47:48 +0000
X-SNPS-Relay: synopsys.com
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Thread-Topic: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Thread-Index: AQHZzrigBue/3poh4EyicQs7iCe9Ya/qAD3g
Date:   Mon, 14 Aug 2023 16:47:48 +0000
Message-ID: <DM4PR12MB50889D6CC25880757AB8F146D317A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <20230814140637.27629-1-rohan.g.thomas@intel.com>
 <20230814140637.27629-3-rohan.g.thomas@intel.com>
In-Reply-To: <20230814140637.27629-3-rohan.g.thomas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLTRiNWQ1YjQ3LTNhYzItMTFlZS04NjJlLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFw0YjVkNWI0OS0zYWMyLTExZWUtODYyZS0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9IjYwNCIgdD0iMTMzMzY1MDUyNjY3NjQ5?=
 =?us-ascii?Q?NTgxIiBoPSI0ejZ6SHM5YjNDUVZtbXNHQTNxV1hmRGhDOXM9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUF0?=
 =?us-ascii?Q?M3JRTno4N1pBVHJIWVhUOElPOGJPc2RoZFB3Zzd4c05BQUFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|DS0PR12MB8413:EE_
x-ms-office365-filtering-correlation-id: f983942e-4181-4de0-0295-08db9ce63103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0lnwYDxKHTyjYGozfPCjAdEi8TVs3DNH+ix3OTiSuran1wv+NnhmgSj81yapJoHiOfsSVmLve1jgqrY0xUEjr5tWaJyeZeHhSoIOhHxSJHxgCEJked8kh3ttl+bcxSrijkbvZT5jtHt3/oS3gdpHFprT9VBocfR12EwFckLQdsxl6ogtJ2V3fNuPL0PCyYfLIcGk37AbrZKZzAKcEZ2n18/YkpVO/80fiQ+ldn0WpUd9a/1s73pDW73n/AZgzeuhrfdkrvqp1gdNXWMpJAvZ5bmJU6EwgkEaTJClAKVS2Q9n+l9H7PdRULyd7vFYRTRvaan60uV48IGX+CmYnNRI5FWSKM4R21Ph1zYkvKnQ7CHxmDJ8YK4NdQVeg70OplBYknxKn341a51YcQJgQmqozsgEJzW4cfJApJ0NtcMuz27n30QZQNnoSXZ0/wVMFavN8M8BZltEVWq3B/zPm5qof1jOeyieEnYsJjznAVwbSjBNz0eqx7vul6Fk2AJTPaf3aBwmKAHZY34L8qK9wkDx1qqIRLGmG3ILcnbPeY1wJAFYJtu6rTXXL/bjm0NtK0pQg1a5H7f6k08KSB1ZyOG+Dkdw9LZNjoUQQTUuFB1FQkUVjCQMn3/h3wSLZHzcfoqKwVki3D4lLQHDRUDVGH9vvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199021)(1800799006)(186006)(55016003)(38100700002)(54906003)(110136005)(7696005)(71200400001)(478600001)(122000001)(921005)(52536014)(7416002)(38070700005)(5660300002)(2906002)(4744005)(33656002)(86362001)(4326008)(64756008)(66476007)(66556008)(66946007)(76116006)(66446008)(41300700001)(8936002)(316002)(8676002)(107886003)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BhGGiQSV89KIMm4OYJp+RK35yk6HCgj4g1nZFUnQnXxVZF41hfU42ob+HgYs?=
 =?us-ascii?Q?ryrV/+3PhzDuRj2STHn3ZeNIdox3WIQvJ/7xYBk/zAPApc9NGQnuxg2Erl3A?=
 =?us-ascii?Q?/LDw81hzlnUbPqRLNiqnCJYfjZR9cZjH6pPxYNHdsCQIgbaRNi2KJA/uuOaT?=
 =?us-ascii?Q?dTUXmmcQdth1my+kCGWnjbdQ926IhLDrWxW6XjfIOPXzIaBnikFkdr9efNjF?=
 =?us-ascii?Q?i/aJyi9i9PMg5adGXM0wgChHCFz79J7IUgQgmKHQDGdKiv3YsjKFqb+nYdTk?=
 =?us-ascii?Q?SdfyOTeh5kZBDv38Ss3TiTaAOR6d7IR1ZWVdYRe/nBHoADe7nKkn29LYH8Y1?=
 =?us-ascii?Q?4dXwXbMa/nw9swefjDia5mdUDX/bVxgoEddwKNpgQ9eanRP6L9jSMMcsZ7nm?=
 =?us-ascii?Q?aWmy4yk/DZeDi9uHrFwtrC7dy8IWQ4eaDTgKr1Wwh36N6SHd2WKcsJ8KJ+J7?=
 =?us-ascii?Q?LHDCvO/jB0039J8yWWuHlGiwJt0vMpOW2eWUxMjC0nK/u0fgs8vKorntBTHQ?=
 =?us-ascii?Q?HXS9XD439F/WafT9zBH4PZJQZIbWN93I9r2T29TT+qi90RYNH/4s8JLekyTE?=
 =?us-ascii?Q?ooahJX6pmOLqnNynk4xBP2bkF6mpRm6EuEdPlmSTPh7ruwsufqC8ugwYb2jh?=
 =?us-ascii?Q?qA3SNagvLeToztSWsERLbWd9Yftb4WusamdkT9j27QvGrR3AV+D6xDeke+2/?=
 =?us-ascii?Q?yXRju7eiVByA6yMv8yOJqr1O18gdTrNsRRjg56rbBMtRwsRSGhCmChhvlClE?=
 =?us-ascii?Q?/EJJ0ngY6SA1c9ubqV7Vg4/nV7KEJ0yYFjl4Cu4KsAqMh5UzSCHjoL4UNG6X?=
 =?us-ascii?Q?UCsmvMswzkc4jQRbWn2yopAjhJ+g1gIWay7nUzOiUgCNBoaWjSD7JJRoyISc?=
 =?us-ascii?Q?bplmG/m3wSPsQR4SiH9xyFhl2VagaGvjR26dthdgDerbiaWYNbgZGicTcIZ9?=
 =?us-ascii?Q?X4qCv78tiSfnwi7FJYkwxMzlUTs3K8b664LHHZ9JmZT1+LdF0hzpx4y7q3Aa?=
 =?us-ascii?Q?5TcwAKk/4fU5sg4R8iP7SyJA/vY1tNCVJF9sY+akuzPWeXGA/hi4vD6ic3G3?=
 =?us-ascii?Q?Zp8my3hc4A7zIpY7fdTL5nWRVpImxL9Rdeo1sYXjwWHYcnMBMH3ulQ1Xsvld?=
 =?us-ascii?Q?BUWB49dShmN9mjO4hiRBWiw9UD8h+2O3yVd8aw9wH8khEUro79ef3ScocKcl?=
 =?us-ascii?Q?MWPig5HfUZGH4DLrqWhBwoVNccpU1yZfXnywIhtVQBEweV0kqW2FmOT25FZD?=
 =?us-ascii?Q?x6xfOQwXY8SBDpj9JLq22NcJQ4nWT3WHI0n1Xv4ieKINh7WCiMqr5cVd294Q?=
 =?us-ascii?Q?q5NAKqvKv8qBfSsEBUL3lHm4o0Qalc0yzzPkMP4qIWbF2dEoHZ6n3tNPQOTz?=
 =?us-ascii?Q?WFMhi2lI55IFWnGRRXOv/t4AI71f02czn91mDqBZ+TKa7bvDUoQW/hpjtfGx?=
 =?us-ascii?Q?c07AgFWeUxdnrVO391FWzxrb62pm7XZQ9e5r59RACpiD7rbMNDNDy2fMtoyL?=
 =?us-ascii?Q?8BA6XgQ/1l22ek7MUlU7o+EJ6yWr2e8n29ybm1TymPTo0mZiDkX4hFa8X08B?=
 =?us-ascii?Q?LPU34PSVr+2qf+hCJwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GPDuKZQYYySY/F67/mpAziDgvf46oXzQMDisLsZG574sp1zuytUyuq/Kp+bj?=
 =?us-ascii?Q?u7eDIp02BpDI6nJ7G5g+c6oiRXwGacVQ6mR4bmYJ+jklm4ms9SqLQFOlaYai?=
 =?us-ascii?Q?GKd6npf0mC5fkQCKhuy/vV7cO1D6tWW7A161PxNArvZMW9SRYlfYdYN5+qUW?=
 =?us-ascii?Q?vE5oygThrW0y8fl9HFE6m015LCkgLtJ7h+zhahXU/fDe5clfAAEb5CEo01cT?=
 =?us-ascii?Q?Is+Sd2hU3UDz9GHBhoYqnIhbZwsCvjHqXtVsy4KdCXb8PDD5xzQqmKLxfIe8?=
 =?us-ascii?Q?oSJVJbrD7PpeOA4ls0jwK29yoVZ3m/1iz1FogxI30bt7FKqEh1vvlJd4deTx?=
 =?us-ascii?Q?XN0KsSEDXcrZY5JyQTZiDyeuZ9vwk6yRBHC13DnPbTvkqPi7EwOK6UpQiTs8?=
 =?us-ascii?Q?8YhPnqBCwih1BOScT77jIi8SgrwPbDULQ86BF/Tnpdv06W1alT/ONunJ4b23?=
 =?us-ascii?Q?KL8r1eSaxOSLCl2DQJk7NZcgDzkw8tbw2oMOZy4gh5WLrWWfa41eJsAlYp+e?=
 =?us-ascii?Q?RH6fXpanpAzG7I4JeyCSkfHC49ANLuXv0kZ94tunYowhm9qTY4/mOPYChgGw?=
 =?us-ascii?Q?eArEVcv/B2qFZKnm1BxdICeyuAY9hr7hJ8c6qacVH67vjyIJA3A+5T+37X9x?=
 =?us-ascii?Q?+g7xhOrXy9ZRAACFWR7btIQ53f/UJH8j0NkHF1K2Gh0GI2hK0P83UtIfydmk?=
 =?us-ascii?Q?emu4dOnc8s+xmJ/br4f3lup7OVFoedVSkV1IxmgjKaSEsFl2jGmlCvsvlUsR?=
 =?us-ascii?Q?d2wc3QjLfPSWhUMC5UPW0KdqtATRC6UIVZSkf+NL6kY92tgaRFb+DNn8tZ2C?=
 =?us-ascii?Q?vhfWan8nME1o5Gdssveg3Q7ADR/w1obydJkXUqnSjfx870K62/e3kKmOoWDZ?=
 =?us-ascii?Q?1CjJ+iOmFy4bX6zwI4Bc6TeVURJU+YPhsudPC4k/CrmiESB/kXih4RnFvKqo?=
 =?us-ascii?Q?lQcYU25FISX0+jP1z7Vr35GRIXM49cnlSONWn/Ih4MBecNstmG6vYGgomNsh?=
 =?us-ascii?Q?+kSSxjOTKJTyDafYKkrabb4BG0WCZPKs1kcgQ2z1a8YsalpFeEsP9BExu4h5?=
 =?us-ascii?Q?yMHRzaWW1IcRHs+vpWQEzPUZ+IVxBTn9yAnNGDZKB36tF5cZhbJuXyYutit0?=
 =?us-ascii?Q?eqEx4aEZBYAEw99SoHq91GnnH/sBAUOewXWha1hwD8ZiHKQQaGBIM7G2hbkR?=
 =?us-ascii?Q?+Z27ZYti9L8csfUH?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f983942e-4181-4de0-0295-08db9ce63103
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 16:47:48.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gNmP6WIAYMecWPR1ec/B0SfbkzNYMYOjMSNNIk58ZqYERo1GxjaG8DrNkwx97UEUB2E58rAxJVYmewb7cBzAMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413
X-Proofpoint-ORIG-GUID: -kjoG90HZ2pv6pE9KJ9SVHfDEnTyC9kn
X-Proofpoint-GUID: -kjoG90HZ2pv6pE9KJ9SVHfDEnTyC9kn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_13,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140154
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>
Date: Mon, Aug 14, 2023 at 15:06:37

> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
> @@ -219,6 +219,8 @@ struct stmmac_priv {
>  	int hwts_tx_en;
>  	bool tx_path_in_lpi_mode;
>  	bool tso;
> +	bool tx_q_coe_lmt;

Please use a flag here instead of "tx_q_coe_lmt". This is the preferrable m=
ethod now.

Thanks,
Jose

> +	u32 tx_q_with_coe;
>  	int sph;
>  	int sph_cap;
>  	u32 sarc_type;

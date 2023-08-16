Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C908777E586
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjHPPq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbjHPPqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:46:17 -0400
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACB2D49;
        Wed, 16 Aug 2023 08:46:08 -0700 (PDT)
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G9et1L017868;
        Wed, 16 Aug 2023 08:45:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=pEn1MBIZt+4GTmYz07ynLvRrnvy2bg0+sxdQgSRvLgk=;
 b=tPri7hyd4PVstMtOymvJwfQFWCNVqg86ijTFuVv2tnnyV+8EmjaN3VyRVFGXrZ10CDqQ
 OxaDrZwCRmZpkQzLWr+GG+FFeqmgzebXIvYFcXWZE21XjdDF3jsBWO/QseSEQW2NgN2B
 havtehQfwKXrECDNqtGinfI9gzTutwosSZWiEGQB9V54qOb8Xd/osFbURzWVOkPBzDKp
 rhlbUjSD5GrmSS/TjTEmW7DgCep/EnYmWIb4N3mMmpYkg6hHpF7xuf+btay1plcUrWOS
 U8xpYIaPicA/+PqhCbuTk3V++2kOLNRppp9/9zyUkwncYOpIETi4tnlItpSrJhrLVZQE mg== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3se93kj2h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 08:45:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1692200721; bh=MVHyWtxVTX8U/J0ywASNDht793h8/NjnpFrXngjVqQQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=WGAxYxNeoOURL7EV61hp5+3V0HYvIGm+hhMY/Kf623XrJXXrj0d7eLATNVDx+duNV
         8KJiJJUvvApJe7tsDyxPRNBk3AmR3WrTkhaJ6C44GpHHmo86X28bDrGpNzYzvt63ZL
         uoWx6hcO6n+dPckV+wnDOAsnUckQJiiBrntpT4+VauE4TdWJSs1TURPElj92dteYF7
         SP58+NKi0mSQLdZDZx31L7b2W9CEkGq58TQ1nFQ1824be6T+gv63D+m4Bd00BAxNsY
         7UcN4KiC3Pn/WBvMJekBg6PjY9roWr95zran7DLTDqA6bbGKCIQ+eaiby7E55LBDx8
         qDC6QgqbTqFIQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits)
         client-signature RSA-PSS (2048 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 54F85401CF;
        Wed, 16 Aug 2023 15:45:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 942A7A008A;
        Wed, 16 Aug 2023 15:45:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=g9VHIL+y;
        dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 97E9540354;
        Wed, 16 Aug 2023 15:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXOu4TqIVotFcGb2WpFrI7ew9G6IaZ7X8joC78RF0vfP5WpxEQ1Wx8SkdzRdiFxLyTLwhy0PQvwv7LdFEKe8Adtwu16Yys5LdvmraObdzdYAT9rLbpeTmFA1hvxmfKfA3/THoRhHY+WPswzeXsRORMNuz/uULPbJXNcyRaGqEJ9JjOE2Hgfy8YLpKpcBCb7qzQTmUo62XqxlEkgz2X+lM1L1HWMElsxWhdnD0mmhtI40De5dTLWd3QcniM9rHThxdtEH5OGBwpZWSMjdF+RPZYAV6jeJtgtLNi15JlSKPTpfh2GVYh04EQnikZR2xy0VBUfZ3AggM5GNYO3jdyKMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEn1MBIZt+4GTmYz07ynLvRrnvy2bg0+sxdQgSRvLgk=;
 b=exaISu4UaUbQyNB/7c6f2lx37YVA8h1f+UbnmAQFOCuAOJuVwSh5in5UzQjg5o/YQzXfYoW2rXOT7+Vn5uLyLb1c2NDC2Df0zHaaOH/c/kXp/ut0ETIC+bhdbzYsW7/8DgVQxLXeOyD6qiygNlzjgJGQxfOR2/BvekH9U2fDitvP+b1Y+5/DJG61qrsAEAjxLY7p/RIbdKfA3F4wAhLgmtxNLdLXMH3ZEjj/A5QYQmgtvhiOWAXjwwgBuIRAbOpteTjWua999RW0xvIkKWeKnZnHJy9lCnFuwgYNCvwC1vJ+VPBkpTPpLzByy3ex4dx8Z6YBKcQX6T7mx7DWMDHWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEn1MBIZt+4GTmYz07ynLvRrnvy2bg0+sxdQgSRvLgk=;
 b=g9VHIL+ycImO0SwacOkVTwAlbwJvDQQ3dGqrPExNnX4ZJEdEs881kCj/j76If3ZX+x93xhqgIuFOXbIb1Y8cnPXwPCGItj3ZA+VXPlYDY2SKSJrCG15oNuL1O7BxEsnOwX6pJv0XdUY2oqZUKPIG91LYk6i0bwDBIs4dKBVEV2k=
Received: from DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) by
 DS7PR12MB6261.namprd12.prod.outlook.com (2603:10b6:8:97::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Wed, 16 Aug 2023 15:45:08 +0000
Received: from DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5]) by DM4PR12MB5088.namprd12.prod.outlook.com
 ([fe80::e258:a60c:4c08:e3a5%3]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 15:45:08 +0000
X-SNPS-Relay: synopsys.com
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     Rohan G Thomas <rohan.g.thomas@intel.com>
CC:     "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: RE: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Thread-Topic: [PATCH net-next v3 2/2] net: stmmac: Tx coe sw fallback
Thread-Index: AQHZzrigBue/3poh4EyicQs7iCe9Ya/qAD3ggAAYfACAAKF0gIACWXbA
Date:   Wed, 16 Aug 2023 15:45:08 +0000
Message-ID: <DM4PR12MB50882D093C2880097F90778BD315A@DM4PR12MB5088.namprd12.prod.outlook.com>
References: <20230814181354.8603-1-rohan.g.thomas@intel.com>
 <20230815035145.16990-1-rohan.g.thomas@intel.com>
In-Reply-To: <20230815035145.16990-1-rohan.g.thomas@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcam9hYnJldVxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWRmNDNmNjEwLTNjNGItMTFlZS04NjJlLTNjMjE5?=
 =?us-ascii?Q?Y2RkNzFiNFxhbWUtdGVzdFxkZjQzZjYxMi0zYzRiLTExZWUtODYyZS0zYzIx?=
 =?us-ascii?Q?OWNkZDcxYjRib2R5LnR4dCIgc3o9Ijg3MiIgdD0iMTMzMzY2NzQzMDcxMTU4?=
 =?us-ascii?Q?NTMwIiBoPSJZTGtGSi9XZzIvcGZ1VGNSRTdVVksxYlFPQU09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFIWUlBQUFD?=
 =?us-ascii?Q?Y1p1aFdORFpBVEk5Z0p4c3Z2bjZNajJBbkd5Kytmb05BQUFBQUFBQUFBQUFB?=
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
x-ms-traffictypediagnostic: DM4PR12MB5088:EE_|DS7PR12MB6261:EE_
x-ms-office365-filtering-correlation-id: ad7ef59e-523c-435d-370a-08db9e6fc4d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOb0H47TFjoLw0EpUo51RssTTjjh/RNMkzlC9nNbT0FUcDSH8p8sqL63Tw5WQQq0rezYGEhTPtifBG/pRDLxFTMn0CX+F4OnoGw1NP5cAFUd4O4idTQhVbFUJ2fPXcIyYoSYb2KXqU7LLqloR/3xDU43luuWzWK501K7JL8ZwzcBvTtae7W/lNaEYWYg0nfYK39QNbcaRIv78iwzMo3kGth26yXdDanB06L2bCHC2OGL0ChKVdFcTQpNUzJHa1gBG0y5uQFKwA76UlIgABXVle/dTtfyjO7qyihbEDE/JcWwQasjnb98lH/otktP7c7aK/P72WTmE2vXPwFvyHWRwlKF7RXqECuPxrA38H8RxYBxqZGknBnKXWGaYu9Vcy7Obk2avuh/BjGAsr5jYsZtyx04VmBCyxY3sCanJwSpPK2FZQx1SscxGk34dPV+OijQRdkdAnDpjW3Jpv1MSmUiwsdRJ/gDwAPE2qcpd1iNhkZD5SbxC+4ztn6RXELgok4Jv2bXw47tlfW9qw+pH/lpBWPPOyHCJtpCZCHm6yZGXGj/ELzG06gZGw5jemtMhl8rdPCpxaylMCntyNd+oek5Z16A/YHIPISp9Dc+OCSocpU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5088.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(54906003)(76116006)(6916009)(66946007)(64756008)(66476007)(66556008)(66446008)(122000001)(966005)(41300700001)(52536014)(5660300002)(38070700005)(38100700002)(8676002)(4326008)(8936002)(2906002)(4744005)(83380400001)(26005)(55016003)(478600001)(7416002)(86362001)(9686003)(33656002)(107886003)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RI4WiLi/VsbSipwRvQ3uDeP4a1pHozcnoDgW4FQ29kXBIG+nTzuwrabTCtXP?=
 =?us-ascii?Q?Di54weBSvpPFjWYTKqRX6GCncvdDb9FBaM46b5zL1S6SHkYkGqzKVXg4ezeH?=
 =?us-ascii?Q?btsyxnQxMcizzlhiddwsfkBjepBU9a/m8G9S1UiYdI3ePhCRxdPwRMBwbbR8?=
 =?us-ascii?Q?S8eZ4mLfzGz7O8hxBAyevacmnDJZsIoo7V5WxVL5ftsWEzeBuBcL1dn4nojs?=
 =?us-ascii?Q?7hq5+e2I+sy83gCzFuMFlGzCBO8lkSNtIbFcfa6pEQnvP81Wco3FgXiXxTlc?=
 =?us-ascii?Q?6WgkTNfIXZqvL1wGBMhTzZlffNIWy6UhzB2vw40PEdLeGb1OSVA4fYec+LoJ?=
 =?us-ascii?Q?4hp0Wmi2OW011Rlr37dP3RvByYIDO/3aYU+EVrwpSBLOI3G2xwUXeNG9McjC?=
 =?us-ascii?Q?kzF/oPLynftfS4L/e4zLGqge0Pzw1KadMKGkNKUh3Fgj2OlzkFlBXesGl9IR?=
 =?us-ascii?Q?SiqimwK1Sij/CnNdgDvc2LDKwJH7YnWmDsszVCLWXT1reYOQws+zBo/WS7qa?=
 =?us-ascii?Q?F47k2fQNBGD5UqREh1XmKbFu1upFDkgSArCBObwVg1+UybgVq1he8ASeB7Gb?=
 =?us-ascii?Q?eESCv2j+T+wwoiWKtqjq/LjlEpTBfksOWpGQinXzimXsrAYOQcJM4ggw7Too?=
 =?us-ascii?Q?MqiF4IQFOWJ0lLPa6/wp2QVYFsMBV2mOZaQFbtAa5hi8DPq9syA4vCWHDo9s?=
 =?us-ascii?Q?7jEFPAouyHbFVRgASEyJcQ/7RMtNS1vCNJj69uqq10LzzdjAPc0UlkLdlPRw?=
 =?us-ascii?Q?f+XzGrNzhHCfB8676aNFsshMkRvAOKPZ0cNbx0GzoAUzzZCeEVncooQ2mJvx?=
 =?us-ascii?Q?OC6emVAmdHtu2jHQrgXFTP8fWZHoFn4R8mopLfYs2HJ9hV6NILGf0qbfl0k4?=
 =?us-ascii?Q?oF8opbE7mctkyb8gj9+vC2vj6XztnGjpxH0izXNVTOkVGlQVCJFdKD+TmPny?=
 =?us-ascii?Q?HvdPJmEVGTRFuQhblGbgKLGO9BaTcPQ8wZy1D+/bji/fr323Ciup9xX/iQ8r?=
 =?us-ascii?Q?O/wLYXBZG9l8eLjEyCzItCQ4RoEULi1YAFCINaRWhqGacSE8Pext5aEcH1cw?=
 =?us-ascii?Q?b/AocpI1kSr3Ayrwd0RMK7zD/YwFi56WAE8Js8gqQiRHIJ2iNoMmYIIHrnMC?=
 =?us-ascii?Q?VVxwbRNDnNzHSO8K238nbNM9nT23VoSb1YfO9upw8NaIrZSC4N32gH0oA1GH?=
 =?us-ascii?Q?BfzeHP+7umsZTG2BTSsGnowkIREoIXV80NNmzdsanfFloM+S1TkJN2OkZQwY?=
 =?us-ascii?Q?3L9W89KOhx1Rjmdd2+PmSsAVHp58dtHpkI6mabB9jcpFJnTirPwKMxKOlCcV?=
 =?us-ascii?Q?lDUP9plhHzDPEzOiu4q7oCI1nHAPCHpRk25Y9O+bQ5W4CCsUpV7pw42VpDFJ?=
 =?us-ascii?Q?s7E6HS17ktJfiwZQMp7S7VhgSEjhsogHhEspj6bNtEgkX2HK0jMbwQtYGYMb?=
 =?us-ascii?Q?xc5pW34+aPBmTzsRUhulkz51X4JCxwl0UpbT50bf8qWxfaBjtsv6GCAb6iFo?=
 =?us-ascii?Q?bwURZKzLIghez1+tOszTE4m6CUyPXknYPE8cxuexc7FZvYQkkiQ0VIC3Vnop?=
 =?us-ascii?Q?JR2txzjQZqeqFQhdaay3dxLuc+18GgyMhELmbhyS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CZGxPOvDfIHKVIj0cDzBM3gV9CrAklT0D3SNoaKSatS7aGtDWHibl0mzNAnp?=
 =?us-ascii?Q?5Ti7cFNW+LqffiL+A8ntEVSqM+kyBGZsCczq62NglM6NUooyxapA+Oo5onu+?=
 =?us-ascii?Q?WzT02VN7rtnU/R8+BBcNRqfgbteeIg/BbGQlj1mJJ+9kU8f+VX29kZQQrhDw?=
 =?us-ascii?Q?xGHpbIzqVMe8rIwglcxbHd/onN5RrAyQjDHS5/8ngq+ymkrziluG/1kquGWm?=
 =?us-ascii?Q?SndXpdS3nFWw5CEh9eLHUdpoT0bkeRtznKemEUOJJ4rkxcuAuNsKmjqcGAUX?=
 =?us-ascii?Q?AjeERWiZaa4RwQ6MWJTDhRf/n2ssFSbIzGxBMG7dlIBc08qZVTl6mpsCcVRa?=
 =?us-ascii?Q?5eZA7tJRnvQPWaZUMycFebJgb2w7VRwpxMAQvzaTECLzhl0s1iludrwAftUk?=
 =?us-ascii?Q?9gcUN85TpchhryKZfAcZOAkYybbKTgr7QUUWpe/OfKE5yJXy77npJTm1GOMM?=
 =?us-ascii?Q?otw3ZB53pCVBvEh0H/yUtI2WRgiwSVanYpiLrxXz48x1Vrz9Nn0FBqkVy0rl?=
 =?us-ascii?Q?M/UiIz9hcypEHYQS3NUWEoRYeZNG6z83JNr2zRzkAtpp2v65JWGJvBOUyGBB?=
 =?us-ascii?Q?48dBVjT8naDPC9+tmP9XLYMWV3GrpeGKA47zAdgTyeXqqG/kfwhkpFhdYBbb?=
 =?us-ascii?Q?ZkYoeqebcYjV+/9bB/ID6uX6PMEaJyNqwmFxl09q9XDFJeKrITs/xYrubohF?=
 =?us-ascii?Q?Vjep64m3b7roHRMu5qCnAEloFkz/hJGh5H/tPYOBHXBTAuA8tYs3Mnr/xidC?=
 =?us-ascii?Q?qXEWQYDVPB3LzPSP0ZPxZgASEqz2pyo+6ZNXMX3Mdup+zKIV/me82d6Nnp5K?=
 =?us-ascii?Q?y1esUGd7A6Wjy2DPfiVDkvfyOJhVOnq9ZotioZ5NLacObogvVcc+ptfYgSVb?=
 =?us-ascii?Q?4gLzNsCgH087YvNQCHa4c5XuDd5K4YtS9QEk75od0PeEvt3Tvd99fqkAfa/9?=
 =?us-ascii?Q?9sehhe3z6bysgrLvySwIKYfSXdJMordYFKNsTfUUXIFSol069ihVXcESZPnR?=
 =?us-ascii?Q?HMmiBH4xse09+jGJAWpkTIyiBb57upRSl89o4ixS+GIXFZvADWuBatIDJUdh?=
 =?us-ascii?Q?lAXKQ5HZA462d2AUyaNcejKKfYsbJP7ujvbLL15UizqEt7SByJa5HLsnXQ9t?=
 =?us-ascii?Q?cjxLo7idUXx68ZJFuKdMjIflZtLVXxPSUZPb9XuEahGf4snyfl/xnjIVQCZz?=
 =?us-ascii?Q?V1jazYCOaNNC+aKD?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5088.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad7ef59e-523c-435d-370a-08db9e6fc4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2023 15:45:08.3532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCfM1vxuZi33rOYaYl/leQwJIGovrgjaDayQvMQz+yW3NU2oPvssuhBmGR6y8S4xtvv90rtDo6war6mh7hrUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6261
X-Proofpoint-GUID: DY5ddj-JmPahx32YA1Cj2Yk8r5y0Grml
X-Proofpoint-ORIG-GUID: DY5ddj-JmPahx32YA1Cj2Yk8r5y0Grml
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 mlxlogscore=888 adultscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308160137
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rohan G Thomas <rohan.g.thomas@intel.com>
Date: Tue, Aug 15, 2023 at 04:51:45

> From: Rohan G Thomas <rohan.g.thomas@intel.com>
> Date: Mon, Aug 14, 2023 at 15:06:37
> > > > +	bool tx_q_coe_lmt;
> > >
> > > Please use a flag here instead of "tx_q_coe_lmt". This is the
> > > preferrable method now.
> > >
> > > Thanks,
> > > Jose
> >=20
> > Thanks Jose for the feedback. If I read that correctly, your suggestion=
 is to
> > change " tx_q_coe_lmt" to something more readable, like "has_txcoe_limi=
t".
> > Please correct me if I understand it wrongly.
> >=20
> > BR,
> > Rohan
> >
>=20
> Or, use int instead of bool?

No, I mean to replace it with a bit flag as it was done on https://lore.ker=
nel.org/all/20230710090001.303225-1-brgl@bgdev.pl/.

Thanks,
Jose

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1277E4B90
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjKGWNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjKGWNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:13:17 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04hn2218.outbound.protection.outlook.com [52.100.162.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1633283
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:13:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNtsYDoxGr/n74hUpDC5tgAfkW73WpCOjwfaHu3mj8uYTnhLkbx9k+tqLQHqdNOvKXf1j4OOGNW43KmGlnsJRm5OvWCtBuqI3DFAhz3InRYBFT8QC9OOSa/rf4Pvml/27a6k9ncjW3KEhl9P7ahKhMZswUhoRPhI6nI+/UaoHztw6ttfqeWP3kaPXmh8PA8Am3obvI6MfgDzBgorD4ju5q9QP4Xd3o4OrIUirlpExH516Yp266KEnecS+vq7z75CByPjm4LuU2p0QXa8fOV+N1eGOX+aGmP1C4CGHh3gdJoXboNmVV2Y2YfGPoxnZktrujoQWw6GiI6Ty8/4e/JirQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fGsR3MfJCj0+jGvO0P70LlmK01zviHPbcWorCorBK0=;
 b=doxW1+z8IUC9+HPls8XmAgKtC/iertS9LAudtYJAuulQRO1nQzr1N3bIkc6Rg1cFdXyHUXHvWK91rlbJi3RAbig1FLlmFlq85sHYZ3HP7Kupt1i2IB49a3+Y5Gsr/epDZHsnCurSjRCOE09ByqwdlMzZCA6uv95yPdaYSaiTcEAz101hgDQY38yHXHhYl+07LQkkaXQ69MXLAQVUvhmFHBXlCt1wdWOUZsugC7menIaCC97cxPjroCWGwXPJiE5QLJLXBPJyjqfcB08gW4yqTGhKdFU0SSO7tSe8nyzPBKCzPydZ6Svk9yw+ra1d4xDNxIC4mJgfW8on1WHk5M0vOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fGsR3MfJCj0+jGvO0P70LlmK01zviHPbcWorCorBK0=;
 b=YpSFXl2G6cYE4p9rkD5un+sFsDH7vjuv/lhaZ2RUjEdijuHqG6B7b5rA9XSXSIrTNVQ+bZnVne1Zx3UJ3q8Oi9wDQKEVHgRBxfL/aU1Qiqhu3rzJYSaCPo7XsGt0HdezzYTCKpkmC6VvvGpmFzHwvYK0Z4HuEZFSjNSk1QaiRHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW2PR0102MB3595.prod.exchangelabs.com (2603:10b6:302:13::25) by
 SJ2PR01MB8659.prod.exchangelabs.com (2603:10b6:a03:578::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.18; Tue, 7 Nov 2023 22:13:10 +0000
Received: from MW2PR0102MB3595.prod.exchangelabs.com
 ([fe80::bfe2:cf53:9a23:f07a]) by MW2PR0102MB3595.prod.exchangelabs.com
 ([fe80::bfe2:cf53:9a23:f07a%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 22:13:10 +0000
Date:   Tue, 7 Nov 2023 14:12:58 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Raag Jadav <raag.jadav@intel.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm_cspmu: Reject events meant for other PMUs
In-Reply-To: <169936667591.2397489.8626905802471861575.b4-ty@arm.com>
Message-ID: <f3661af2-7fdf-d828-ef88-5732a370c0c@os.amperecomputing.com>
References: <20231103001654.35565-1-ilkka@os.amperecomputing.com> <169936667591.2397489.8626905802471861575.b4-ty@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH5P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::9) To MW2PR0102MB3595.prod.exchangelabs.com
 (2603:10b6:302:13::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3595:EE_|SJ2PR01MB8659:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e5ff689-71e6-4b5e-ea7a-08dbdfdeba04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEXB1UZtj8dBWqEsGbWkXGm3lRy+/aTRT7CxdtLb3LWeNZ8oXBpINVm+1227?=
 =?us-ascii?Q?v5GK3vSyFiNXKP05w6WjojTzSxVyIj0BZBhUnQuOKahAg8zE7rYNsOIKO4+7?=
 =?us-ascii?Q?VqDCk10493c7fFBr4MNeyXb5qbfJwWVwqyFrWyaECcQNA+ttJoxA33XLYEjH?=
 =?us-ascii?Q?D+DW2l1FvyRx+UrYGzUpGMNZ+drp9I8tCrsuj2381B/3WnaSo2SdZAZzLbHb?=
 =?us-ascii?Q?wy7iS8tY3AokM4NqqHXM2IB/mSRghrhJngfubEQXioyVlK0rQ5mdBsQoJIKH?=
 =?us-ascii?Q?O3EJl1lCLw+gcyuZ58Hup8M3qDTOszSVQ5fkU+m+Cc2WrSe3nAYvxYVxFF+1?=
 =?us-ascii?Q?eZ8he88vSgmvAZk6YmzYirU2jNMbqEgaBI3l9rJVswhgpFcKhSB5Pcj6INCJ?=
 =?us-ascii?Q?xC5xedGzM5FX587ZDmtM2FL7v78J/E9h65J5/Jssb/OtyR97H+YGVrpYP1aF?=
 =?us-ascii?Q?+2zAdEOhTu+YUd4iExDSvSgmqXiXWPGpRyEmQXTyy97aBG6SVyXb0OjxncQ6?=
 =?us-ascii?Q?otd/R3c9QVOElN2sxB8+LA6yeD3o1lVbd3DjdcOJCfRM7M8CHfi1HDtNav3K?=
 =?us-ascii?Q?qn9uvapYx8UIiDkGwZN6wEIFpfaAGk22Xjimcaderil9Ervt9/u2e6JXxeVv?=
 =?us-ascii?Q?B447NDvYcddjZDu/yPDx+rxmV3QwxHvSk+NZtqQ0QdSqN0QFQA0GC7fP4mbd?=
 =?us-ascii?Q?wpsZyfeG7+JQ5wOitfn/QthfP3Ta66QkCifQOVq7v84OVhCxrf7ic9x9TMv+?=
 =?us-ascii?Q?xVNFViOPwUPJ3jnLDI9974d5l81WBAanOiDHJVcUN3/KbAbqPwPgA8501tUp?=
 =?us-ascii?Q?TXN2x4cQ2bDqg0glps5Ou8DBaWhVXiAfNPpMuhacLFBmyj8PAfb961y+Gr6n?=
 =?us-ascii?Q?YMZHQtBk48SLhUYYnn3DMC0ryF8Vm5oOjbsebY+vKgI7hEH7aq2UuHT3R7Bo?=
 =?us-ascii?Q?//wVsqz8uKUyuz4PbxrCmPtONJ5ofEpI+4HaijZVq7BAEgu1YvZzsEsFG3Ta?=
 =?us-ascii?Q?yKZ8EMfMQujM1PIoO2pGJKtNCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:MW2PR0102MB3595.prod.exchangelabs.com;PTR:;CAT:OSPM;SFS:(13230031)(346002)(376002)(39850400004)(366004)(396003)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66899024)(6512007)(5660300002)(2616005)(6506007)(52116002)(41300700001)(2906002)(66946007)(4744005)(26005)(66556008)(66476007)(54906003)(6916009)(316002)(8676002)(4326008)(6666004)(8936002)(966005)(478600001)(6486002)(38350700005)(38100700002)(86362001)(58440200007);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U6d5TXvXFY9yiVY7BcRzqoph2zUKLizxkHM7SzpZi6fnWyTsCNivHDaL9WCU?=
 =?us-ascii?Q?vTvsu1o5bj/ojo5vPFRaohYqvwyBkF0bdDOkOL7w146QuiRtQvy6KkRivcPq?=
 =?us-ascii?Q?aijfIN/EQGXRx5WpzHP7fbnMj11N6sAG6s4c1oPvMfyT68enNuWaESBT2OQ2?=
 =?us-ascii?Q?ndv4iG8L3gNzKjGbuM9ydhvSad5yPPb52rK8QWxAWtYT0H1A9CH2Q0MYn/7w?=
 =?us-ascii?Q?zZQMBcBu7Epw0RoPMPQBouhOzrQ7HGcl5igvlVpkqUO9jIhVQ94TGIBmkk77?=
 =?us-ascii?Q?qdkdz1h7BXiU0qZe85kXR5vxjpRmpvttZDnnqmBe+SJd9Lf29NOTmRCDWJmo?=
 =?us-ascii?Q?8Fv4T6Hf/vudgsLjQ1O0JucvOLdzAJe3kibeEo0M0lxnnenpllAj2Pqzirbb?=
 =?us-ascii?Q?0e/R8L+rnuP7cgfT32op/vTIfJOJjDVOf7QTZ6ZqX11mWzb8py3y8TvqLN16?=
 =?us-ascii?Q?Zmmx+hI/8f+LzAH9qH3zDkEQNoMyMULSHBoCryA6NoqwVUZ3PzN8LZ2nOiqS?=
 =?us-ascii?Q?IpvLbMmXWp88SgmKHoCEUVHvzzpWbp9wOieugvF5zMFI1Um+p9aNeXhY9It/?=
 =?us-ascii?Q?e010wx3Fc9LF2oPpyWKb+bA2hEiWScDenqMAaiu8k5mksC8yQWthS7ykJzvO?=
 =?us-ascii?Q?Kmdk49VbUFz5/TkHU+jHgMEMV/LfptbhASiFFMcNwW2KY/V0K01qG1Qqb+jP?=
 =?us-ascii?Q?IkmydLbg9Or+z8n/fCGw1C3slDVA+CWRO7a+vRoAeGGI5Zk6Cc+16ck9yTQj?=
 =?us-ascii?Q?qKYb+nix/ZOeveuCYBJDVqNN24gYzFzYl1PPIqMqCZvh9sVxfD10Evn0LRCl?=
 =?us-ascii?Q?QyUIdH5RCbhhk6mJAEB1kbblkndFOr57PnvbJPOrB5229FOLqj5JJdOCDMi6?=
 =?us-ascii?Q?FgtOvGErDaZit63e3w41HaLZ0GZaS+Ik5BcWgH+XcAGcSOSBKBmz5YpZmGid?=
 =?us-ascii?Q?T5o3U5hATFVOWWbSj9ONZPJqjnPwuHGPmFHMPGQXmvVRxM0gtCER3UFM1Clv?=
 =?us-ascii?Q?5DMb9KvG9TFcx+yYhazqblomcWaDKr6KY7RQRvIcfsatjly7KNFnN8hhN5XV?=
 =?us-ascii?Q?iF7SghWoco6lNAuWa59Ja9EX1KbNBQCiu6bpJdj1FN9V546Jx3rVpR9fZGht?=
 =?us-ascii?Q?r5503B1b4LmmNc7zSAArSAw4QF8nfgca5LEJXUWbMA/JQU6pkcxfmF7wrYzV?=
 =?us-ascii?Q?+ve78MhBlIOdJJOEHEMaQzJh/8aTZm+CGSUhE94MYep+l06jQIeusQqK9VY1?=
 =?us-ascii?Q?/feeMx2ETUucQZ3qRatpdIhtsURPP/dNHCuQFGUwRJOF7k0uwDvp73RDi0F9?=
 =?us-ascii?Q?84h0qoxgKRgC5CLEybAdxpVnQFagq2TGmvGlanWOYDDu717MZ0KGa3T7bjtF?=
 =?us-ascii?Q?q+0I8jvcZe3ZY8cSunomt3ciDyeVBlQUCRukCr60bAG5ToDL7xIfAC79DdHD?=
 =?us-ascii?Q?9QYMj4gUnIaKzt4EK7MLAMZ91I8gJzi4Z5ylWt3CX1/UDlpJPEbcmQJJ2SRQ?=
 =?us-ascii?Q?PCRdgNknsQ7XdWKWIPLSTTQfxTpjO0x5hmwI9mbpNPfswCIOvYuqnTeJ4yjS?=
 =?us-ascii?Q?A6oSz/OVfC7CyrCurgjtjtm0lyCtqqUKwyD1B9I7hGtpLgA6TD0RtIx16mNY?=
 =?us-ascii?Q?DXgseEGUR7rwcePxYIZGpbU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e5ff689-71e6-4b5e-ea7a-08dbdfdeba04
X-MS-Exchange-CrossTenant-AuthSource: MW2PR0102MB3595.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 22:13:10.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nOkulpyjAyB/5uRTQKqSWWHmC4obFJ6AV8v0e5mFLL9g3dlIz6Ufao8Wka3yOnvQOnMtV+eYohQlRjDixYOyVJTvbZ/KM+QMzwcsyagqhLb4N4xzCdr7OhE3hl08pJHS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8659
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Catalin,

On Tue, 7 Nov 2023, Catalin Marinas wrote:
> On Thu, 02 Nov 2023 17:16:54 -0700, Ilkka Koskinen wrote:
>> Coresight PMU driver didn't reject events meant for other PMUs.
>> This caused some of the Core PMU events disappearing from
>> the output of "perf list". In addition, trying to run e.g.
>>
>>      $ perf stat -e r2 sleep 1
>>
>> made Coresight PMU driver to handle the event instead of letting
>> Core PMU driver to deal with it.
>>
>> [...]
>
> Applied to arm64 (for-next/core), thanks!

Just wanted to ask if you are planning to submit this patch for 6.7-rcX as 
a fix? We have found out that one can even crash AmpereOne by running
"perf stat -C 1 sleep 1" without the patch.

Cheers, Ilkka

>
> [1/1] perf: arm_cspmu: Reject events meant for other PMUs
>      https://git.kernel.org/arm64/c/15c7ef7341a2
>
> -- 
> Catalin
>
>

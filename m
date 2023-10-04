Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19B87B8695
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 19:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243709AbjJDR33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 13:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbjJDR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 13:29:12 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96ECFC;
        Wed,  4 Oct 2023 10:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhJ8P4iIMSrVCQfZ4qCrrmYbwqnVPLyhCAhIyhgrxRP9uq40Q8SJVcP0bVkoP4G7b1hSdS0d1FBO6XjjYRQWg3jQmOX5sUdcXjtNUBucGE4PpEwB8ZUTa0w937+QG1jwqjfagQ/UTouxe6n2HR+8D4/11kywau1fTXqaJ5+7Gg2lgDguHb3rPR++pzAI+kyo5EhmqxEEHCbKY03WI7k2EPTAHsb3Y2PK1usqJuuuuU9/4IerLkiC+qfc5ocFMfk1c7+HVbZnXtMimYxYQqtx6xMGxZvYVlQPgEsGzEz8E6hvmbXgiX/8hHWqajNhgzPb6lY+acq4KZJFaB5beXvNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6nFqrlsCNFUBc16Ioc8XPt2MHtqcMhvTI8S6mM1dcgY=;
 b=ZKGE0PVXXQcxMHBexgM0a82hGFqOfelXY7ux0dNB3u5sl9IfJyPkojc0FNUSGwqiZQ+gi3RcKAzgO/hGHV3PMfDPokzlW3ZjEc6r4abDot1v05iXtmKO+8AjWp/0FvdZD/lYBJYKRB7hTEjqqX2cDhiOWxQyPs+lzNDarskjsmy/AASZeI/fpMDg5Uj8yPKhqKKvR/TTaJpuh1eXKjbSDq08dLb1RidrjFg/B3BCDioVJFJhfkIp2Bc4PjTadtRO2PWDmUbIzWi8SUaf68ge2GgBWxeNy9HpaIkyhE0ZVk/crcyFbUpuJQD3H9IhL95bnRQr/aS68P1x0+NuJsQHtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6nFqrlsCNFUBc16Ioc8XPt2MHtqcMhvTI8S6mM1dcgY=;
 b=Fb/c5669A/l1DrTPR2uIqd027UEDhS4WEQUHt3W+GO9gWHfKFZbX6I2Vllc4VnlKSTviSJ4EAS/fPiwtC+EGVjhUI+DRWYCJgGoDuAyX9yl2jKwS522w/p4lvEiSFE9WLLuiXsi708EEXABqBD12uqCbslEYUAxtdjJEHdOnh5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=silabs.com;
Received: from IA1PR11MB7773.namprd11.prod.outlook.com (2603:10b6:208:3f0::21)
 by PH7PR11MB5982.namprd11.prod.outlook.com (2603:10b6:510:1e1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Wed, 4 Oct
 2023 17:29:01 +0000
Received: from IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3]) by IA1PR11MB7773.namprd11.prod.outlook.com
 ([fe80::d6c8:4cb6:2594:d8f3%4]) with mapi id 15.20.6838.030; Wed, 4 Oct 2023
 17:29:01 +0000
From:   =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>
Subject: [PATCH v3 4/8] wifi: wfx: introduce hif_scan_uniq()
Date:   Wed,  4 Oct 2023 19:28:39 +0200
Message-Id: <20231004172843.195332-5-jerome.pouiller@silabs.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004172843.195332-1-jerome.pouiller@silabs.com>
References: <20231004172843.195332-1-jerome.pouiller@silabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: DS7PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:8:2b::25) To IA1PR11MB7773.namprd11.prod.outlook.com
 (2603:10b6:208:3f0::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7773:EE_|PH7PR11MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: bc88b17c-7cd2-4cc0-d98d-08dbc4ff65be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24FkOJ4GPDkHQnUPUOY/J5d5AV6aBmCrA/y2wpD1LUcMxhA+slrckDgZ6v+Vhj2Si9YgfNc+HzzSNDWZUU/lcqDuzbaeiTzaKbkrkmWcJEW5lD+FfitXhkHkjmvjTiH5TwgneHQCKqPTSigbl6EoM4dMueKI8CvA/mMw6evseNdbY7v/KgTmWGuTwySOeU3W3Uphj0GiJ3tcjwC/R4WzasrXdamP742NNAttNe60sGLotSckKNPq58YtIvEW+VqeBjOXokEscRJAVN1mJohyZfCAEYGRQ8hHDFHhENWTVJUj6P2FDcuksyerytucQaByNsoOD6QHqj4FYVuCvj2epE+qIBsWY0T2Cxi3G0BYoeN9RrOy8/cEl5gk3HA8bcqyAMNbeCcoQOvf6BzYYDi7v1tsHZIEYprYRUTbb3+V0lJKy8A+rtImcUgDCNrfOtY0vImrzj35hTfCV2qwv8Kco/EhE6QxbJyz3WnT0TP2c/98HQ49Ijm0T2505lFg8PQMHX6HBDFGENvlMcPqTCKytPFDkbU7H+Ro681AT/P5Qs0esxMBbIg+6T56Kwo7e2tx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7773.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39850400004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6486002)(36756003)(6512007)(38100700002)(6666004)(52116002)(86362001)(478600001)(6506007)(66556008)(66946007)(66476007)(316002)(6916009)(41300700001)(2616005)(107886003)(1076003)(8936002)(4326008)(8676002)(66574015)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnd3QzVxU3k5QUxwSnMza1RWTTViUS9HbS9QcnBGNTFnNjUvYmhHWDJaZUt3?=
 =?utf-8?B?UzBUTmx4NndQY1lPYnJhVEVjektId0ExS2w5aW1rWStvc0hpS1d5Qm54blpX?=
 =?utf-8?B?eHNzTUJrelJpQ2owZjFaeEF6Qmh2NjE3TEdSdm9pT0FlMHM3cmtPT1MrVVNX?=
 =?utf-8?B?L0FOYmlzZCtmcjRzblJWMHhOQ1dtaEo2YmpVMjFWQStKYXlhWU05Y3hmSlMy?=
 =?utf-8?B?TjNIQWVLNjRBVmU0TlU0U3Q2aStvdU4rK05PaVpFSmduSVNYMGIydTR2dVRh?=
 =?utf-8?B?cXpkWWRRb2ZMcDl0NitISnllMU94ZEtvdE5KMFRwMTQ5TTFBOGdiMG5WaDh6?=
 =?utf-8?B?WGZkRGtNOEhDQnBGa0MwM3FnYytNamxqbEVKbnVsdFJtM2VwY3BhTDdlNGVY?=
 =?utf-8?B?a0FMUGhWNEVYZVllTU0zU29YOFhGWm5EN3pycXdhR2dUcXprOGNUaTZMSmg1?=
 =?utf-8?B?eE5GZTRNZDZTZjI4NGpsOXVvM3ZSeU1CelJ4TVBqN2pzZFF6TlpyeWorM1JS?=
 =?utf-8?B?QkpLWGtsbFZkYStBVldVbFhTdmxLT3l5Vjk1eXVmZ3IxMzUwR3N5OWFCRTFm?=
 =?utf-8?B?UFVBM0JMaUs3NS9TSlBXV2M1MnNXS284NVRsVlBLTjZWQWRSRFJxK2orK2hm?=
 =?utf-8?B?cTV1ZzVZRmxpV000YTBLYWY3Qzgwc0pNZzJ2cnFzUjRHL3gvYktuMytaaDdU?=
 =?utf-8?B?VlpwR2taV1JhV1l6NUxvWWh0U1lhUkxDbk9FTlU2N0lSdXQ1S2JJQWJud2lR?=
 =?utf-8?B?NzNkblVBSWNHNEh1UXJnMkVPK2U5WU9zVmh1YktJMi9jVlZJMmYvNTRqcHYv?=
 =?utf-8?B?RHpQVEl6cHNBbzBRRnJ0ZW93ZVNwWm40WkQrUVpLRTJBR0RGY0VqSmhDdnlZ?=
 =?utf-8?B?cVZQenZuVTlmOGU0ZGlIK0prVWN2Y2ZRUmVmMTlQdnQyenp5Ulo3OUJseDdV?=
 =?utf-8?B?TjdoWlZXaWw2K0laUCtUNVRkd2liYnpsY3JSOU5HbFNoc0NGUmp4MmlLTDJS?=
 =?utf-8?B?ekNXT3JUdGhyZEwvNGcrUVZBaDhxV1NzLzlZUHlmcHNUVzNXck9LaEpJd1lE?=
 =?utf-8?B?enU3Z0ZTSTBtNnhEOWswSTVGNGV3VXQ4c3RyOXRhMzh4VlBaZ1VBakNGREdy?=
 =?utf-8?B?Q09Sc01RRnlmS3R6VWUzOEhSR2ZacElYaTVzR2x1cUhqOGZ3K2N5MFdhSEd0?=
 =?utf-8?B?QlUxQVZzSWl1cmR3bVVEUFFwNk10d0QyNXFyOW1ZSFRpVThHbFROd1RleGtF?=
 =?utf-8?B?cmphUndMTWZqemdXVXBNMnZXelNCZVUycjhRK2hQaHBjLzNxOXIzZkVQVWds?=
 =?utf-8?B?cTVhb3NZeitYRHJXL1B3eGFFVHdBUVJRejcyZzV6ZnJ0WmlTeXFTZVdzRG1C?=
 =?utf-8?B?TWYxK3ZhK1hLQWNjQjE3R05BTFh4eWZlSWpPdHVNRTdVKzcyNUNYcUNlS211?=
 =?utf-8?B?ck52WHBlVWpQdjJab0djZ3A0NzRKcTFGSDBySjVlb1g0VU5abFhFcDhKdnhi?=
 =?utf-8?B?OTFDWTBhbXBSYTk1bFZHWk9Jb0NEeHd0dDNuejFCUm0xM3RpSEJwdnhNVnJa?=
 =?utf-8?B?NEFsSzRxN1BvdElWeGQ1NDNwVjJyd3dQZy9yTVZlbTJYUzl3amRIUVl0aWxV?=
 =?utf-8?B?WitsMHRIOGZuWEFlMERRUCthYnFpYldYd3RXT1IwbEJNZHJEOTV3Ynp4bXo5?=
 =?utf-8?B?d3d5SXlJM3BmV0tFSnZmOEt2aC94WC9xY2RNSVRiRUdmdmk1WFA1dnRuRjEv?=
 =?utf-8?B?czF0bjZCU2pLL0xkN2lXQTUzZExCaHV5b211SXk4NzIwL2hKdGJKL0I2ekJN?=
 =?utf-8?B?cFJ0dDhvdXAzdFl6d3g5TFZTNTJhNHlXMHBNNlE3dE5BUm9jeU9UR0N3ajZu?=
 =?utf-8?B?Q25wWVhhQzNyR1JIVERyczlUUzQvS3RiTG4zcVczdkpDUkZGWVVDalZMeTdu?=
 =?utf-8?B?NWROQkx6WlE2WlY0VzZlRzQyNzQ5TVMvYjBFK293Z0RONkNaR3Q5R2VCS1Jt?=
 =?utf-8?B?cy8vSllQN0xLVHVnYXhhaGVRR3ozY01FakhOQm5CWkExL0JMWnBmRnptVHBp?=
 =?utf-8?B?bGNFamRtUVFPYUpHUVZzWmwvVG9MOGFYNW9wN3B0TDB2ekFZbWtKZm5iYWoz?=
 =?utf-8?B?Q0hUKzZ5eXVoWG1qRzlOZUMvT3R5U3ZRN292cWk2dHZzeWJIOE0wMnoxTGNy?=
 =?utf-8?Q?N2mK/7lqlpUJqNh7USmWCwWChBEJTT3i53VnnG/ttitp?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc88b17c-7cd2-4cc0-d98d-08dbc4ff65be
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7773.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 17:29:00.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9xIopHvYs7d+UrEJqcYWpt5O5KZ+0ldJF+ekGkc0FF6eWXEJgHf17SSWLtBEYiGozqasYG7I/WuOEMTdxj0ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5982
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TGlrZSBob2Zfc2NhbigpLCBoaWZfc2Nhbl91bmlxKCkgaW52b2tlIEhJRl9TQ0FOLiBIb3dldmVy
LCBpdCBvbmx5CmFsbG93cyB0byBwcm9iZSBvbmUgY2hhbm5lbCBhbmQgZGlzYWJsZSBwcm9iZSBy
ZXF1ZXN0cy4gSXQgd29ya3MgdmVyeQp3ZWxsIHRvIGltcGxlbWVudCBSZW1haW4tT24tQ2hhbm5l
bC4KClNpZ25lZC1vZmYtYnk6IErDqXLDtG1lIFBvdWlsbGVyIDxqZXJvbWUucG91aWxsZXJAc2ls
YWJzLmNvbT4KLS0tCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90eC5jIHwg
MjUgKysrKysrKysrKysrKysrKysrKysrKysrCiBkcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMv
d2Z4L2hpZl90eC5oIHwgIDEgKwogMiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguYyBiL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmMKaW5kZXggZGU1YTMxNDgyZGYz
OC4uOWY0MDNkMjc1Y2IxMyAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mvc2lsYWJz
L3dmeC9oaWZfdHguYworKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5jCkBAIC0yMzgsNiArMjM4LDMxIEBAIGludCB3ZnhfaGlmX3dyaXRlX21pYihzdHJ1Y3Qgd2Z4
X2RldiAqd2RldiwgaW50IHZpZl9pZCwgdTE2IG1pYl9pZCwgdm9pZCAqdmFsLCBzCiAJcmV0dXJu
IHJldDsKIH0KIAorLyogSGlqYWNrIHNjYW4gcmVxdWVzdCB0byBpbXBsZW1lbnQgUmVtYWluLU9u
LUNoYW5uZWwgKi8KK2ludCB3ZnhfaGlmX3NjYW5fdW5pcShzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZiwg
c3RydWN0IGllZWU4MDIxMV9jaGFubmVsICpjaGFuLCBpbnQgZHVyYXRpb24pCit7CisJaW50IHJl
dDsKKwlzdHJ1Y3Qgd2Z4X2hpZl9tc2cgKmhpZjsKKwlzaXplX3QgYnVmX2xlbiA9IHNpemVvZihz
dHJ1Y3Qgd2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQpICsgc2l6ZW9mKHU4KTsKKwlzdHJ1Y3Qg
d2Z4X2hpZl9yZXFfc3RhcnRfc2Nhbl9hbHQgKmJvZHkgPSB3ZnhfYWxsb2NfaGlmKGJ1Zl9sZW4s
ICZoaWYpOworCisJaWYgKCFoaWYpCisJCXJldHVybiAtRU5PTUVNOworCWJvZHktPm51bV9vZl9z
c2lkcyA9IEhJRl9BUElfTUFYX05CX1NTSURTOworCWJvZHktPm1haW50YWluX2N1cnJlbnRfYnNz
ID0gMTsKKwlib2R5LT5kaXNhbGxvd19wcyA9IDE7CisJYm9keS0+dHhfcG93ZXJfbGV2ZWwgPSBj
cHVfdG9fbGUzMihjaGFuLT5tYXhfcG93ZXIpOworCWJvZHktPm51bV9vZl9jaGFubmVscyA9IDE7
CisJYm9keS0+Y2hhbm5lbF9saXN0WzBdID0gY2hhbi0+aHdfdmFsdWU7CisJYm9keS0+bWF4X3Ry
YW5zbWl0X3JhdGUgPSBBUElfUkFURV9JTkRFWF9CXzFNQlBTOworCWJvZHktPm1pbl9jaGFubmVs
X3RpbWUgPSBjcHVfdG9fbGUzMihkdXJhdGlvbik7CisJYm9keS0+bWF4X2NoYW5uZWxfdGltZSA9
IGNwdV90b19sZTMyKGR1cmF0aW9uICogMTEwIC8gMTAwKTsKKwl3ZnhfZmlsbF9oZWFkZXIoaGlm
LCB3dmlmLT5pZCwgSElGX1JFUV9JRF9TVEFSVF9TQ0FOLCBidWZfbGVuKTsKKwlyZXQgPSB3Znhf
Y21kX3NlbmQod3ZpZi0+d2RldiwgaGlmLCBOVUxMLCAwLCBmYWxzZSk7CisJa2ZyZWUoaGlmKTsK
KwlyZXR1cm4gcmV0OworfQorCiBpbnQgd2Z4X2hpZl9zY2FuKHN0cnVjdCB3ZnhfdmlmICp3dmlm
LCBzdHJ1Y3QgY2ZnODAyMTFfc2Nhbl9yZXF1ZXN0ICpyZXEsCiAJCSBpbnQgY2hhbl9zdGFydF9p
ZHgsIGludCBjaGFuX251bSkKIHsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Np
bGFicy93ZngvaGlmX3R4LmggYi9kcml2ZXJzL25ldC93aXJlbGVzcy9zaWxhYnMvd2Z4L2hpZl90
eC5oCmluZGV4IDcxODE3YTY1NzFmMGIuLmFhYjU0ZGY2YWFmYTYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3NpbGFicy93ZngvaGlmX3R4LmgKKysrIGIvZHJpdmVycy9uZXQvd2ly
ZWxlc3Mvc2lsYWJzL3dmeC9oaWZfdHguaApAQCAtNTQsNiArNTQsNyBAQCBpbnQgd2Z4X2hpZl9i
ZWFjb25fdHJhbnNtaXQoc3RydWN0IHdmeF92aWYgKnd2aWYsIGJvb2wgZW5hYmxlKTsKIGludCB3
ZnhfaGlmX3VwZGF0ZV9pZV9iZWFjb24oc3RydWN0IHdmeF92aWYgKnd2aWYsIGNvbnN0IHU4ICpp
ZXMsIHNpemVfdCBpZXNfbGVuKTsKIGludCB3ZnhfaGlmX3NjYW4oc3RydWN0IHdmeF92aWYgKnd2
aWYsIHN0cnVjdCBjZmc4MDIxMV9zY2FuX3JlcXVlc3QgKnJlcTgwMjExLAogCQkgaW50IGNoYW5f
c3RhcnQsIGludCBjaGFuX251bSk7CitpbnQgd2Z4X2hpZl9zY2FuX3VuaXEoc3RydWN0IHdmeF92
aWYgKnd2aWYsIHN0cnVjdCBpZWVlODAyMTFfY2hhbm5lbCAqY2hhbiwgaW50IGR1cmF0aW9uKTsK
IGludCB3ZnhfaGlmX3N0b3Bfc2NhbihzdHJ1Y3Qgd2Z4X3ZpZiAqd3ZpZik7CiBpbnQgd2Z4X2hp
Zl9jb25maWd1cmF0aW9uKHN0cnVjdCB3ZnhfZGV2ICp3ZGV2LCBjb25zdCB1OCAqY29uZiwgc2l6
ZV90IGxlbik7CiBpbnQgd2Z4X2hpZl9zaHV0ZG93bihzdHJ1Y3Qgd2Z4X2RldiAqd2Rldik7Ci0t
IAoyLjM5LjIKCg==

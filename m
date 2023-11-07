Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B6B7E4C99
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344336AbjKGXOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344455AbjKGXNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:13:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B32D4C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 15:11:16 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJxpn005003;
        Tue, 7 Nov 2023 23:10:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=k15juSm04x0tXyAu/KVbvACcXdJqJhxN8ZJRpjJLcno=;
 b=djlzHqV+4JY4Hf/meVarhHorTwhmJS5R2j7FqLTPd9ML5eZzqDftD2+g0OY0YyNr3Yua
 7SWn/CV6BNuAzwKN6la7l5rMUGK6H8mm2sM1BPJrNbRT5ouu8qHRpcFcifordgYcFKwa
 TURJbHuAElR3k6CTwKVci4c/LP43VzvKKKm8jomqxMK0fS1/1r6Bv5SMreG+88SDtc80
 NZvKLVnDkb+fuI/eag4y9ALQjOTVQ8lBlFolggCYnHVktfZJN77jJqEYBjzGRmLC7+V7
 VtQX+PH+ERd9eKt+Uag8QgOPmGi10ZMJ/7o4j0K/wwwMiVc5TkytjfKUOj3eJOmCLT4y Ag== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22g6cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7N1Mwx004090;
        Tue, 7 Nov 2023 23:10:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vvcm9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 23:10:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g++vlHR0e6HKiaDG5QgeW78ELgON9OYl7ZPWFE+1fBkd3Vc/OhhIdG/C53yjZN9FFGqABW+U/QmuWkDCbXVV8bY9cp7LQ37gBTrc7ihsyyoHVTLUrQyM95P0SgwMuvMKcxnqNmgnGUObJa1lXrf78i60Kj17gUCr4xkrJBSY6+UfbnGr+YZfkDUqezwtSlA4tbg7jRzRlc6JJyk7EH0g5DM++xAGwEYNKc6u9o4Ynb2mI0ejGqZrfkSELULYJ225pTStR5JUI4n6qX3Kfy9T8xCuT7UtylIaZ1I4FpLWkoEfCvP5B07gcMfplKkM7qt5nwzN/e3INE8mG/dZr5mWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k15juSm04x0tXyAu/KVbvACcXdJqJhxN8ZJRpjJLcno=;
 b=n6k5mt5LSdGNddw48nwLAzW8xSSnynIiR2+mMhsoqt4zkWlI2uP5Yytsw2aD8VyzO3D5s0XobEUpmelEKDkguw9G+wbOXWvzh6Xl59LTNvBvleG04P7uj3zQaZPSobAHCgBAaIFm0gnwRPPiIfS40zIEesplyvMYdpX/dBLKCAhjp829kOC01MSbjOELcCXF0vM0Pi3F/CkCsBtQnKNbiQfjuylbiQ7Yeazv9u7WIWNQVjAxVW1mPxEdgNyAFJ93fgD6V5N/M9pvCl58F5W9gFsEA8FaqGgtKlQsTmkR69rw+7x6Ndd808SLH+3aBV1BCrJeHFX1ZIAbNoXA4d5B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k15juSm04x0tXyAu/KVbvACcXdJqJhxN8ZJRpjJLcno=;
 b=IrHVf0cYx0GjTtB3KNnwUmjKOj3uCownPNQCBSU/q2pYWFXx350UTPUeCfYN51fEPLVJBQ6TyBO8/uGJc0C56DYqKXO7LQRDE2iPjJqww2Y6lXifJHlqMCpvZnjMin4ZRDxx0NJofO+hawJwtopF00c0GZsctqW6Ej9vhmqVVPQ=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 IA1PR10MB7261.namprd10.prod.outlook.com (2603:10b6:208:3f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 23:09:58 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::c72:c098:4fc2:629b%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 23:09:58 +0000
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
        Ankur Arora <ankur.a.arora@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kalle Valo <kvalo@kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>
Subject: [RFC PATCH 84/86] treewide: net: remove cond_resched()
Date:   Tue,  7 Nov 2023 15:08:20 -0800
Message-Id: <20231107230822.371443-28-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107230822.371443-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:303:b5::24) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR10MB5416:EE_|IA1PR10MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f87f1887-20d9-44fe-a06c-08dbdfe6a968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Km3ZTcR+tGuSR8x8uMKMEluwl9Hk3KHAowZSxMZrUS+Gorq21LUUyC8yCj6cS+kEEa6pez2yFK69MC0djkI4lLip9qqpJg8W3iCWMWo7AFc5PuxzgdJLMH2JcO8hvYLg+o3UJ60lrKkcZ4FPwNZE3v0DO4OabvLGSX1Gap0Bi9o+o/u2e++7T+PmKUa5wAyQUjX/o343XLU6SpACgcgF4rNaz7ttWaiJhGXHN0t0zyGlApR135ReUlwJGybHxIUkiQorIOAQ2q4E2oyWDIhKFCRYPLufn/9wSH2f9E+iyoT9W5sUWvdujbAoBD+NhTuRw89l/IK/h1vR0O6ooa9iIPhA1Q7c21LuI4RsKGK77f3XVO/rcoj7D35kZbKBnrH6RJN8ByHCihETczTfxod/E8SOSb/yv/1+o/gcgK4aMnzCIQJp5YqWwrvG89kO/h1sDnN+3p+nMmqW+rhPDFFDf/7ocohLfDi6lg2s29w4xn4yqOF+TwAEPt+xinDr75ZrCxNncTvygCuinxZJLIafhKjp3FUmx4xX+M6tO3FLOdk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66899024)(30864003)(6506007)(478600001)(6512007)(2616005)(6486002)(966005)(6666004)(7406005)(36756003)(103116003)(38100700002)(86362001)(1076003)(41300700001)(7366002)(7416002)(5660300002)(316002)(66556008)(66476007)(83380400001)(2906002)(54906003)(26005)(66946007)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fo/tk6gJUJUZNlUU+v0tzkEJNJBmURfa1lvp2BCtt/u2wd04KRraLXMo3Sh+?=
 =?us-ascii?Q?t8HVQ0pLZ6dsv+FptUAe8pXjfwTxxyw80RBHJrCdSxf/LvbW7GICtLRNSvQP?=
 =?us-ascii?Q?o8Q+9NDvVLJiYaVThLzl17+/e5ozu20UaynofEpnr4DtXKYBDbOm6ayClRHu?=
 =?us-ascii?Q?1MboBEx95rcxAsDdvyZFPLDbOQKT0DthxtEbXv1dGwWrXSFotlrJHh8clTTQ?=
 =?us-ascii?Q?wNVC6ABmeRqIrq+gpCENT0S6OdAPjOxcgpBgjfcKJjTIcUS70Ae65w/HTtCP?=
 =?us-ascii?Q?irBYE93FJq3Hh1FOagHET57k2H6qTsm/AUyZuPE0AQDWWl4SxpbdQYWZYLqX?=
 =?us-ascii?Q?llx1IC0pU5EwFkzGoKoR9kSY7sDmg9io349Va/GGVAX51jhaO8cEOYHMwd3W?=
 =?us-ascii?Q?QKb92YPpGoONAvCbNgwh8TS5E8tmzQ35D322Mk6xMfd7WcZJMPLaK7WMWRFM?=
 =?us-ascii?Q?3cdqBF10yCMXHTi7O9nkQ3Y6NCOAo0XaWll6h/nu7a2884HoOVFBn14pPFIo?=
 =?us-ascii?Q?goOQWwRQ+P086aDoPY8GjdZ/f4M8DJYXw3YBizEzIftNEFsiiuZfjqyG0WXg?=
 =?us-ascii?Q?ulZE2i6+/cgjLLLcOx+e4QYp0oTL9T/JFAkXxP0joOmMxk2MdCcfPRK0RsjN?=
 =?us-ascii?Q?Lz3FYNm8cwHe3Wv7XfINRRB1e2zF0sXTHRle9dbLfxGVExSl7I4ZmZzNgYOd?=
 =?us-ascii?Q?B66Nd/AnTn1h875vXytSVHwJQwC9AkIBZXiLbU1sBE2SI87N9GcBiDaa10qc?=
 =?us-ascii?Q?4PkkN+fMIE/tlNtyfOXT8X24Y+nL9njpceDvFbpx8MjsdJjM3iLUrfzBdmH6?=
 =?us-ascii?Q?JIon5xSViyVYZyjik0AFwgl/NA7guS8aQpas853uAjLQlbB5g8D+Dq3GASYN?=
 =?us-ascii?Q?ynAAuAnvMWKBnaRGK2OMpM1aSG8yQY29r49JtqQBmF1cWi7BsLrsWPnoPr2k?=
 =?us-ascii?Q?sI4N1Tt7NavF5k5NBIFSs8iKC100fR3e/4/qmQU3jnaqgQXJ1SU+uyu70bWa?=
 =?us-ascii?Q?cYKKO2SN/Kno9psYORVeCOqD7Fcf3HD/PDU+TzfGYLYbeRP3vszBVpMCI73t?=
 =?us-ascii?Q?hoKp8kvtSQwAJzsTvzCJrKmmHRUuXq3stCxjnZ9iWdi5E2/69hQ7P4cczdBL?=
 =?us-ascii?Q?yoZmi/8kz2Jb1z9/O9/iwG6OX1m8F3IpS0kttJKb7cLgSmkgMjt4ge5VkXF9?=
 =?us-ascii?Q?N+l0BxHVqnjmqGUvsXnFJnOVUR7b9uD0lcEXyGrOzx0flgUUppeZNUqXGcgA?=
 =?us-ascii?Q?yJWFLJwFZ7fYeQcqKhWtMsxYRz1SDkWoPwfWfl6fiv83dvshi/4fZpFoBd9a?=
 =?us-ascii?Q?dBR2QyR9Jrz+ilhjj2+LB2djVH8unJU/WEz7DOI6XRjPXD6xi6fdH/SStizA?=
 =?us-ascii?Q?yMiDJzD2PYO5pMpC5OLywshTurvN7F8pfym+CTjuV50BqR99EcZoHaFLYAJ4?=
 =?us-ascii?Q?2Qsof90GU0LZlKHABsRDIWyHnDyTwzTmx90ZntSc63vjcxxyHQxk8K3Eb5dS?=
 =?us-ascii?Q?7Hwh3swJXFdg6huSGx1vfeB2lUhyEORZWA7qApA1J0gJ5UOXfpH1q1asyvUT?=
 =?us-ascii?Q?B0qJv3UAZZROhDjgLw/LXwBo6fXF4LA2NdlA9rqM4OGe1Dar+XiJoay+52yt?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?445F6eUuhC6TasiwbKDXtXI2ol701bZxWgEj9GJJ8gNI8a6bkDsJ5kKPYgYI?=
 =?us-ascii?Q?J4pw+TGPG2Q8Cl1puF3ygWBMvBQ7H7lPLLKqIe4b8+lHZPefNXnJh7TwFY42?=
 =?us-ascii?Q?YDsveFELplan376gsdV2hXCuoYCICOXB8YLbqnoTHFIdPJkFaXxN/8T73raS?=
 =?us-ascii?Q?mMEsT5Zp64uVG+vVwoK+1b//p5vtHiPRgC9Cl+kfBZ16aldnqPSEPnCryCPa?=
 =?us-ascii?Q?8yT/OplMv/s4EVRqiy4yAQhSia0IzXhYNJ2xsl1x04e77GG1cYSvi15aFaZq?=
 =?us-ascii?Q?EcNTYClv++vo+82RUvvNYm0IU+Ff1j5lLhO/9xaO8FGzxTC98xlwXJrxOlo/?=
 =?us-ascii?Q?wXR7As97A/ZaYcvpb04A5GhEYfZD3w4KYhinmnzp9fqJslShGy7NHHS7u8un?=
 =?us-ascii?Q?mkkIYC91Xq9lA9Imze+5UBC2MOdlY8powlZUGDLIl7QwQLInOuKG0+Vt0c+P?=
 =?us-ascii?Q?/chr4ylKHLadgvlE20/IA6fTc+E5VPaw3w673doLAskHz3+ZojlZWDPXymfT?=
 =?us-ascii?Q?8afDWNC3IyksT7hhZor2nCCmx0aUh4Y27fRNp1whlLdilCBuWT9MEtgfalFr?=
 =?us-ascii?Q?Pk8Z1AQIu5bq8MT1c4raWGGnbFkG/RftxcYgEoT7CtF1uAUdbtmYh/7gMPGG?=
 =?us-ascii?Q?0PN30foqy3/ph3DS/TDARwYDuQEU2nQKRHHzA8LpyNp7uzFbd6DxfuMW/Cl3?=
 =?us-ascii?Q?M8VtghpDXK2RhMuOOZR90U53uIarPuuYguqOl2/3HH5AEhIMqWat/e+i68Aj?=
 =?us-ascii?Q?8uT2K+YQq3mXG16Aunl4bRCQ1Mk9TcyTj3V0tAq15JGD/dxTI48BWmDGPv6M?=
 =?us-ascii?Q?awctQpNkBlY7LtQYep3HrZ6LkJ+bKE4MIs38vBwBH+2t20vxe7CFX7i/UGFv?=
 =?us-ascii?Q?ABmGXM4jg9vk/JH1R32RHoeMTs07SslETWhXAfk7xjVom0tboX3msMb1p2Xf?=
 =?us-ascii?Q?dZ1WwnEmCS27mzbUeYYdZQcWKkU1eD4R3V++tJdzvETW+IxMNLA3ImUUB0+U?=
 =?us-ascii?Q?SEp/iDmiXXZYrqtSUr63c0yqME39OCEE/wi7/uCzvKfEPMJc7edq24l6BVbD?=
 =?us-ascii?Q?cZQF+v/nl32Lvud6NxDO1bH9uMu70BYkS1InycvhSAvCxspSAc826gPGDVxH?=
 =?us-ascii?Q?xT5ZW2XuviYjKPIgIr9+XngCPD+1nuUn3OZBqXW0lrYmwrvzfZgnCvFZSKp8?=
 =?us-ascii?Q?5+WtI7D6RO8dO9v1ydwlpQAFsYiCO08oay5aVLnouhGSwo1wdsbvMNUh694n?=
 =?us-ascii?Q?3i6AxNU4LPI947JH4r8QJvnWlDC0ilvuJpeMgGEl36VlWuau7stilhhbFjWR?=
 =?us-ascii?Q?VeOzRq1bBU5F8VJWM0bjcC/eF+WG3H7mkXfVGHx0gD40eeN38c6vTB158KPg?=
 =?us-ascii?Q?31W5a+t1PpVCkFd88oduh2UHFEmJZMZmoMxtnVpv6pL+EtEslMdNIZe2tFi3?=
 =?us-ascii?Q?pPEWLPS9mi/d9z2TrVwxG5U7VL1haCJUPRE27XEp3wiudsUx7batdLFuwscG?=
 =?us-ascii?Q?ZTlITZFDPjlxqoSbWf3KNxlPvPolItWwD1iSBM+w3H+H83Ii07URfzDLXfJT?=
 =?us-ascii?Q?NJHDdqy7cCBtWwsNyIVx4ydYo2geSrJimKsSsUkQc3cH+S8kgf2N5P8U1huA?=
 =?us-ascii?Q?n44hfIIXBOLNcHrTmNvAR26HtSItNiQuQVJ8fb0QXQG88rGsDuJ+dAb0gnGG?=
 =?us-ascii?Q?28HwNgtq6Blp6ZtPt6UrvtaFg6UJXwzKXrkaSSUaf2Ey5DOSwdUYsuK/KjNH?=
 =?us-ascii?Q?5RPH5JQzdVsaTE5RO+B+XesiwRSPCn+NwaspvwQfOeUkgM/Mk1/Fh71SIcb2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-1: 6YFP4qr7mLQNpA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f87f1887-20d9-44fe-a06c-08dbdfe6a968
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 23:09:58.3193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRKLVBoZYFdyqQLA90rMG2SHrhJNZSJgqM2cVeNPrzSQStJ2ddIpbaRMHgotdKbmyFadSyp/M/BPKARiUaJ9eESw51e9HixxyvYvovjX6Rc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7261
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070189
X-Proofpoint-ORIG-GUID: rWHSZnaHdLbSTm-26AfDLNgH3os3dYOa
X-Proofpoint-GUID: rWHSZnaHdLbSTm-26AfDLNgH3os3dYOa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are broadly three sets of uses of cond_resched():

1.  Calls to cond_resched() out of the goodness of our heart,
    otherwise known as avoiding lockup splats.

2.  Open coded variants of cond_resched_lock() which call
    cond_resched().

3.  Retry or error handling loops, where cond_resched() is used as a
    quick alternative to spinning in a tight-loop.

When running under a full preemption model, the cond_resched() reduces
to a NOP (not even a barrier) so removing it obviously cannot matter.

But considering only voluntary preemption models (for say code that
has been mostly tested under those), for set-1 and set-2 the
scheduler can now preempt kernel tasks running beyond their time
quanta anywhere they are preemptible() [1]. Which removes any need
for these explicitly placed scheduling points.

The cond_resched() calls in set-3 are a little more difficult.
To start with, given it's NOP character under full preemption, it
never actually saved us from a tight loop.
With voluntary preemption, it's not a NOP, but it might as well be --
for most workloads the scheduler does not have an interminable supply
of runnable tasks on the runqueue.

So, cond_resched() is useful to not get softlockup splats, but not
terribly good for error handling. Ideally, these should be replaced
with some kind of timed or event wait.
For now we use cond_resched_stall(), which tries to schedule if
possible, and executes a cpu_relax() if not.

Most of the uses here are in set-1 (some right after we give up a lock,
causing an explicit preemption check.)

There are some uses from set-3 where we busy wait: ex. mlx4/mlx5
drivers, mtk_mdio_busy_wait() and similar. Replaced with
cond_resched_stall().  Some of those places, however, have wait-times
in milliseconds, so maybe we should just be a timed-wait?

Note: there are also a few other cases, where I've replaced by
cond_resched_stall() (ex mhi_net_rx_refill_work() or
broadcom/b43::lo_measure_feedthrough()) where it doesn't seem
like the right thing.

[1] https://lore.kernel.org/lkml/20231107215742.363031-1-ankur.a.arora@oracle.com/

Cc: "David S. Miller" <davem@davemloft.net> 
Cc: Eric Dumazet <edumazet@google.com> 
Cc: Jakub Kicinski <kuba@kernel.org> 
Cc: Paolo Abeni <pabeni@redhat.com> 
Cc: Felix Fietkau <nbd@nbd.name> 
Cc: John Crispin <john@phrozen.org> 
Cc: Sean Wang <sean.wang@mediatek.com> 
Cc: Mark Lee <Mark-MC.Lee@mediatek.com> 
Cc: Lorenzo Bianconi <lorenzo@kernel.org> 
Cc: Matthias Brugger <matthias.bgg@gmail.com> 
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: Jason Wang <jasowang@redhat.com> 
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com> 
Cc: Kalle Valo <kvalo@kernel.org> 
Cc: Larry Finger <Larry.Finger@lwfinger.net> 
Cc: Ryder Lee <ryder.lee@mediatek.com> 
Cc: Loic Poulain <loic.poulain@linaro.org> 
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com> 
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/net/dummy.c                                 |  1 -
 drivers/net/ethernet/broadcom/tg3.c                 |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_hw.c         |  3 ---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c         |  2 +-
 drivers/net/ethernet/mellanox/mlx4/catas.c          |  2 +-
 drivers/net/ethernet/mellanox/mlx4/cmd.c            | 13 ++++++-------
 .../net/ethernet/mellanox/mlx4/resource_tracker.c   |  9 ++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c       |  4 +---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c        |  3 +--
 drivers/net/ethernet/mellanox/mlxsw/i2c.c           |  5 -----
 drivers/net/ethernet/mellanox/mlxsw/pci.c           |  2 --
 drivers/net/ethernet/pasemi/pasemi_mac.c            |  3 ---
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c    |  2 --
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c   |  1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c    |  1 -
 .../net/ethernet/qlogic/qlcnic/qlcnic_minidump.c    |  2 --
 drivers/net/ethernet/sfc/falcon/falcon.c            |  6 ------
 drivers/net/ifb.c                                   |  1 -
 drivers/net/ipvlan/ipvlan_core.c                    |  1 -
 drivers/net/macvlan.c                               |  2 --
 drivers/net/mhi_net.c                               |  4 ++--
 drivers/net/netdevsim/fib.c                         |  1 -
 drivers/net/virtio_net.c                            |  2 --
 drivers/net/wireguard/ratelimiter.c                 |  2 --
 drivers/net/wireguard/receive.c                     |  3 ---
 drivers/net/wireguard/send.c                        |  4 ----
 drivers/net/wireless/broadcom/b43/lo.c              |  6 +++---
 drivers/net/wireless/broadcom/b43/pio.c             |  1 -
 drivers/net/wireless/broadcom/b43legacy/phy.c       |  5 -----
 .../wireless/broadcom/brcm80211/brcmfmac/cfg80211.c |  1 -
 drivers/net/wireless/cisco/airo.c                   |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c     |  2 --
 drivers/net/wireless/marvell/mwl8k.c                |  2 --
 drivers/net/wireless/mediatek/mt76/util.c           |  1 -
 drivers/net/wwan/mhi_wwan_mbim.c                    |  2 +-
 drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c          |  3 ---
 drivers/net/xen-netback/netback.c                   |  1 -
 drivers/net/xen-netback/rx.c                        |  2 --
 38 files changed, 25 insertions(+), 84 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index c4b1b0aa438a..dfebf6387d8a 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -182,7 +182,6 @@ static int __init dummy_init_module(void)
 
 	for (i = 0; i < numdummies && !err; i++) {
 		err = dummy_init_one();
-		cond_resched();
 	}
 	if (err < 0)
 		__rtnl_link_unregister(&dummy_link_ops);
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..ad511d721db3 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12040,7 +12040,7 @@ static int tg3_get_eeprom(struct net_device *dev, struct ethtool_eeprom *eeprom,
 				ret = -EINTR;
 				goto eeprom_done;
 			}
-			cond_resched();
+			cond_resched_stall();
 		}
 	}
 	eeprom->len += i;
diff --git a/drivers/net/ethernet/intel/e1000/e1000_hw.c b/drivers/net/ethernet/intel/e1000/e1000_hw.c
index 4542e2bc28e8..22a419bdc6b7 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_hw.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_hw.c
@@ -3937,7 +3937,6 @@ static s32 e1000_do_read_eeprom(struct e1000_hw *hw, u16 offset, u16 words,
 			 */
 			data[i] = e1000_shift_in_ee_bits(hw, 16);
 			e1000_standby_eeprom(hw);
-			cond_resched();
 		}
 	}
 
@@ -4088,7 +4087,6 @@ static s32 e1000_write_eeprom_spi(struct e1000_hw *hw, u16 offset, u16 words,
 			return -E1000_ERR_EEPROM;
 
 		e1000_standby_eeprom(hw);
-		cond_resched();
 
 		/*  Send the WRITE ENABLE command (8 bit opcode )  */
 		e1000_shift_out_ee_bits(hw, EEPROM_WREN_OPCODE_SPI,
@@ -4198,7 +4196,6 @@ static s32 e1000_write_eeprom_microwire(struct e1000_hw *hw, u16 offset,
 
 		/* Recover from write */
 		e1000_standby_eeprom(hw);
-		cond_resched();
 
 		words_written++;
 	}
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 20afe79f380a..26a9f293ed32 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -309,7 +309,7 @@ static int mtk_mdio_busy_wait(struct mtk_eth *eth)
 			return 0;
 		if (time_after(jiffies, t_start + PHY_IAC_TIMEOUT))
 			break;
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	dev_err(eth->dev, "mdio: MDIO timeout\n");
diff --git a/drivers/net/ethernet/mellanox/mlx4/catas.c b/drivers/net/ethernet/mellanox/mlx4/catas.c
index 0d8a362c2673..f013eb3fa6f8 100644
--- a/drivers/net/ethernet/mellanox/mlx4/catas.c
+++ b/drivers/net/ethernet/mellanox/mlx4/catas.c
@@ -148,7 +148,7 @@ static int mlx4_reset_slave(struct mlx4_dev *dev)
 			mlx4_warn(dev, "VF Reset succeed\n");
 			return 0;
 		}
-		cond_resched();
+		cond_resched_stall();
 	}
 	mlx4_err(dev, "Fail to send reset over the communication channel\n");
 	return -ETIMEDOUT;
diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
index f5b1f8c7834f..259918642b50 100644
--- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
@@ -312,7 +312,8 @@ static int mlx4_comm_cmd_poll(struct mlx4_dev *dev, u8 cmd, u16 param,
 
 	end = msecs_to_jiffies(timeout) + jiffies;
 	while (comm_pending(dev) && time_before(jiffies, end))
-		cond_resched();
+		cond_resched_stall();
+
 	ret_from_pending = comm_pending(dev);
 	if (ret_from_pending) {
 		/* check if the slave is trying to boot in the middle of
@@ -387,7 +388,7 @@ static int mlx4_comm_cmd_wait(struct mlx4_dev *dev, u8 vhcr_cmd,
 	if (!(dev->persist->state & MLX4_DEVICE_STATE_INTERNAL_ERROR)) {
 		end = msecs_to_jiffies(timeout) + jiffies;
 		while (comm_pending(dev) && time_before(jiffies, end))
-			cond_resched();
+			cond_resched_stall();
 	}
 	goto out;
 
@@ -470,7 +471,7 @@ static int mlx4_cmd_post(struct mlx4_dev *dev, u64 in_param, u64 out_param,
 			mlx4_err(dev, "%s:cmd_pending failed\n", __func__);
 			goto out;
 		}
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	/*
@@ -621,8 +622,7 @@ static int mlx4_cmd_poll(struct mlx4_dev *dev, u64 in_param, u64 *out_param,
 			err = mlx4_internal_err_ret_value(dev, op, op_modifier);
 			goto out;
 		}
-
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	if (cmd_pending(dev)) {
@@ -2324,8 +2324,7 @@ static int sync_toggles(struct mlx4_dev *dev)
 			priv->cmd.comm_toggle = rd_toggle >> 31;
 			return 0;
 		}
-
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	/*
diff --git a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
index 771b92019af1..c8127acea986 100644
--- a/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
+++ b/drivers/net/ethernet/mellanox/mlx4/resource_tracker.c
@@ -4649,7 +4649,14 @@ static int move_all_busy(struct mlx4_dev *dev, int slave,
 		if (time_after(jiffies, begin + 5 * HZ))
 			break;
 		if (busy)
-			cond_resched();
+			/*
+			 * Giving up the spinlock in _move_all_busy() will
+			 * reschedule if needed.
+			 * Add a cpu_relax() here to ensure that we give
+			 * others a chance to acquire the lock.
+			 */
+			cpu_relax();
+
 	} while (busy);
 
 	if (busy)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
index c22b0ad0c870..3c5bfa8eda00 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
@@ -285,7 +285,7 @@ static void poll_timeout(struct mlx5_cmd_work_ent *ent)
 			ent->ret = 0;
 			return;
 		}
-		cond_resched();
+		cond_resched_stall();
 	} while (time_before(jiffies, poll_end));
 
 	ent->ret = -ETIMEDOUT;
@@ -1773,13 +1773,11 @@ void mlx5_cmd_flush(struct mlx5_core_dev *dev)
 	for (i = 0; i < cmd->vars.max_reg_cmds; i++) {
 		while (down_trylock(&cmd->vars.sem)) {
 			mlx5_cmd_trigger_completions(dev);
-			cond_resched();
 		}
 	}
 
 	while (down_trylock(&cmd->vars.pages_sem)) {
 		mlx5_cmd_trigger_completions(dev);
-		cond_resched();
 	}
 
 	/* Unlock cmdif */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 58f4c0d0fafa..a08ca20ceeda 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -373,8 +373,7 @@ int mlx5_cmd_fast_teardown_hca(struct mlx5_core_dev *dev)
 	do {
 		if (mlx5_get_nic_state(dev) == MLX5_NIC_IFC_DISABLED)
 			break;
-
-		cond_resched();
+		cond_resched_stall();
 	} while (!time_after(jiffies, end));
 
 	if (mlx5_get_nic_state(dev) != MLX5_NIC_IFC_DISABLED) {
diff --git a/drivers/net/ethernet/mellanox/mlxsw/i2c.c b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
index d23f293e285c..1a11f8cd6bb9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/i2c.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/i2c.c
@@ -180,7 +180,6 @@ static int mlxsw_i2c_wait_go_bit(struct i2c_client *client,
 				break;
 			}
 		}
-		cond_resched();
 	} while ((time_before(jiffies, end)) || (i++ < MLXSW_I2C_RETRY));
 
 	if (wait_done) {
@@ -361,8 +360,6 @@ mlxsw_i2c_write(struct device *dev, size_t in_mbox_size, u8 *in_mbox, int num,
 			err = i2c_transfer(client->adapter, &write_tran, 1);
 			if (err == 1)
 				break;
-
-			cond_resched();
 		} while ((time_before(jiffies, end)) ||
 			 (j++ < MLXSW_I2C_RETRY));
 
@@ -473,8 +470,6 @@ mlxsw_i2c_cmd(struct device *dev, u16 opcode, u32 in_mod, size_t in_mbox_size,
 					   ARRAY_SIZE(read_tran));
 			if (err == ARRAY_SIZE(read_tran))
 				break;
-
-			cond_resched();
 		} while ((time_before(jiffies, end)) ||
 			 (j++ < MLXSW_I2C_RETRY));
 
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 51eea1f0529c..8124b27d0eaa 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -1455,7 +1455,6 @@ static int mlxsw_pci_sys_ready_wait(struct mlxsw_pci *mlxsw_pci,
 		val = mlxsw_pci_read32(mlxsw_pci, FW_READY);
 		if ((val & MLXSW_PCI_FW_READY_MASK) == MLXSW_PCI_FW_READY_MAGIC)
 			return 0;
-		cond_resched();
 	} while (time_before(jiffies, end));
 
 	*p_sys_status = val & MLXSW_PCI_FW_READY_MASK;
@@ -1824,7 +1823,6 @@ static int mlxsw_pci_cmd_exec(void *bus_priv, u16 opcode, u8 opcode_mod,
 				*p_status = ctrl >> MLXSW_PCI_CIR_CTRL_STATUS_SHIFT;
 				break;
 			}
-			cond_resched();
 		} while (time_before(jiffies, end));
 	} else {
 		wait_event_timeout(mlxsw_pci->cmd.wait, *p_wait_done, timeout);
diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
index ed7dd0a04235..3ec6ac758878 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -1225,7 +1225,6 @@ static void pasemi_mac_pause_txchan(struct pasemi_mac *mac)
 		sta = read_dma_reg(PAS_DMA_TXCHAN_TCMDSTA(txch));
 		if (!(sta & PAS_DMA_TXCHAN_TCMDSTA_ACT))
 			break;
-		cond_resched();
 	}
 
 	if (sta & PAS_DMA_TXCHAN_TCMDSTA_ACT)
@@ -1246,7 +1245,6 @@ static void pasemi_mac_pause_rxchan(struct pasemi_mac *mac)
 		sta = read_dma_reg(PAS_DMA_RXCHAN_CCMDSTA(rxch));
 		if (!(sta & PAS_DMA_RXCHAN_CCMDSTA_ACT))
 			break;
-		cond_resched();
 	}
 
 	if (sta & PAS_DMA_RXCHAN_CCMDSTA_ACT)
@@ -1265,7 +1263,6 @@ static void pasemi_mac_pause_rxint(struct pasemi_mac *mac)
 		sta = read_dma_reg(PAS_DMA_RXINT_RCMDSTA(mac->dma_if));
 		if (!(sta & PAS_DMA_RXINT_RCMDSTA_ACT))
 			break;
-		cond_resched();
 	}
 
 	if (sta & PAS_DMA_RXINT_RCMDSTA_ACT)
diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
index 35ec9aab3dc7..c26c43a7a83c 100644
--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_init.c
@@ -326,8 +326,6 @@ static int netxen_wait_rom_done(struct netxen_adapter *adapter)
 	long timeout = 0;
 	long done = 0;
 
-	cond_resched();
-
 	while (done == 0) {
 		done = NXRD32(adapter, NETXEN_ROMUSB_GLB_STATUS);
 		done &= 2;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
index c95d56e56c59..359db1fa500f 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
@@ -2023,7 +2023,6 @@ static void qlcnic_83xx_exec_template_cmd(struct qlcnic_adapter *p_dev,
 			break;
 		}
 		entry += p_hdr->size;
-		cond_resched();
 	}
 	p_dev->ahw->reset.seq_index = index;
 }
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
index 09f20c794754..110b1ea921e5 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_init.c
@@ -295,7 +295,6 @@ static int qlcnic_wait_rom_done(struct qlcnic_adapter *adapter)
 	long done = 0;
 	int err = 0;
 
-	cond_resched();
 	while (done == 0) {
 		done = QLCRD32(adapter, QLCNIC_ROMUSB_GLB_STATUS, &err);
 		done &= 2;
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
index 7ecb3dfe30bd..38b4f56fc464 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_minidump.c
@@ -702,7 +702,6 @@ static u32 qlcnic_read_memory_test_agent(struct qlcnic_adapter *adapter,
 		addr += 16;
 		reg_read -= 16;
 		ret += 16;
-		cond_resched();
 	}
 out:
 	mutex_unlock(&adapter->ahw->mem_lock);
@@ -1383,7 +1382,6 @@ int qlcnic_dump_fw(struct qlcnic_adapter *adapter)
 		buf_offset += entry->hdr.cap_size;
 		entry_offset += entry->hdr.offset;
 		buffer = fw_dump->data + buf_offset;
-		cond_resched();
 	}
 
 	fw_dump->clr = 1;
diff --git a/drivers/net/ethernet/sfc/falcon/falcon.c b/drivers/net/ethernet/sfc/falcon/falcon.c
index 7a1c9337081b..44cc6e1bef57 100644
--- a/drivers/net/ethernet/sfc/falcon/falcon.c
+++ b/drivers/net/ethernet/sfc/falcon/falcon.c
@@ -630,8 +630,6 @@ falcon_spi_read(struct ef4_nic *efx, const struct falcon_spi_device *spi,
 			break;
 		pos += block_len;
 
-		/* Avoid locking up the system */
-		cond_resched();
 		if (signal_pending(current)) {
 			rc = -EINTR;
 			break;
@@ -723,8 +721,6 @@ falcon_spi_write(struct ef4_nic *efx, const struct falcon_spi_device *spi,
 
 		pos += block_len;
 
-		/* Avoid locking up the system */
-		cond_resched();
 		if (signal_pending(current)) {
 			rc = -EINTR;
 			break;
@@ -839,8 +835,6 @@ falcon_spi_erase(struct falcon_mtd_partition *part, loff_t start, size_t len)
 		if (memcmp(empty, buffer, block_len))
 			return -EIO;
 
-		/* Avoid locking up the system */
-		cond_resched();
 		if (signal_pending(current))
 			return -EINTR;
 	}
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 78253ad57b2e..ffd23d862967 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -434,7 +434,6 @@ static int __init ifb_init_module(void)
 
 	for (i = 0; i < numifbs && !err; i++) {
 		err = ifb_init_one(i);
-		cond_resched();
 	}
 	if (err)
 		__rtnl_link_unregister(&ifb_link_ops);
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index c0c49f181367..91a4d1bda8a0 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -292,7 +292,6 @@ void ipvlan_process_multicast(struct work_struct *work)
 				kfree_skb(skb);
 		}
 		dev_put(dev);
-		cond_resched();
 	}
 }
 
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 02bd201bc7e5..120af3235f4d 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -341,8 +341,6 @@ static void macvlan_process_broadcast(struct work_struct *w)
 		if (src)
 			dev_put(src->dev);
 		consume_skb(skb);
-
-		cond_resched();
 	}
 }
 
diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8..cbb59a94b083 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -291,9 +291,9 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		}
 
 		/* Do not hog the CPU if rx buffers are consumed faster than
-		 * queued (unlikely).
+		 * queued (uhlikely).
 		 */
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	/* If we're still starved of rx buffers, reschedule later */
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index a1f91ff8ec56..7b7a37b247d1 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1492,7 +1492,6 @@ static void nsim_fib_event_work(struct work_struct *work)
 		nsim_fib_event(fib_event);
 		list_del(&fib_event->list);
 		kfree(fib_event);
-		cond_resched();
 	}
 	mutex_unlock(&data->fib_lock);
 }
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d67f742fbd4c..d0d7cd077a85 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -4015,7 +4015,6 @@ static void free_unused_bufs(struct virtnet_info *vi)
 		struct virtqueue *vq = vi->sq[i].vq;
 		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
 			virtnet_sq_free_unused_buf(vq, buf);
-		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
@@ -4023,7 +4022,6 @@ static void free_unused_bufs(struct virtnet_info *vi)
 
 		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
 			virtnet_rq_free_unused_buf(rq->vq, buf);
-		cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireguard/ratelimiter.c b/drivers/net/wireguard/ratelimiter.c
index dd55e5c26f46..c9c411ec377a 100644
--- a/drivers/net/wireguard/ratelimiter.c
+++ b/drivers/net/wireguard/ratelimiter.c
@@ -74,8 +74,6 @@ static void wg_ratelimiter_gc_entries(struct work_struct *work)
 		}
 #endif
 		spin_unlock(&table_lock);
-		if (likely(work))
-			cond_resched();
 	}
 	if (likely(work))
 		queue_delayed_work(system_power_efficient_wq, &gc_work, HZ);
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index 0b3f0c843550..8468b041e786 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -213,7 +213,6 @@ void wg_packet_handshake_receive_worker(struct work_struct *work)
 		wg_receive_handshake_packet(wg, skb);
 		dev_kfree_skb(skb);
 		atomic_dec(&wg->handshake_queue_len);
-		cond_resched();
 	}
 }
 
@@ -501,8 +500,6 @@ void wg_packet_decrypt_worker(struct work_struct *work)
 			likely(decrypt_packet(skb, PACKET_CB(skb)->keypair)) ?
 				PACKET_STATE_CRYPTED : PACKET_STATE_DEAD;
 		wg_queue_enqueue_per_peer_rx(skb, state);
-		if (need_resched())
-			cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 95c853b59e1d..aa122729d802 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -279,8 +279,6 @@ void wg_packet_tx_worker(struct work_struct *work)
 
 		wg_noise_keypair_put(keypair, false);
 		wg_peer_put(peer);
-		if (need_resched())
-			cond_resched();
 	}
 }
 
@@ -303,8 +301,6 @@ void wg_packet_encrypt_worker(struct work_struct *work)
 			}
 		}
 		wg_queue_enqueue_per_peer_tx(first, state);
-		if (need_resched())
-			cond_resched();
 	}
 }
 
diff --git a/drivers/net/wireless/broadcom/b43/lo.c b/drivers/net/wireless/broadcom/b43/lo.c
index 338b6545a1e7..0fc018a706f3 100644
--- a/drivers/net/wireless/broadcom/b43/lo.c
+++ b/drivers/net/wireless/broadcom/b43/lo.c
@@ -112,10 +112,10 @@ static u16 lo_measure_feedthrough(struct b43_wldev *dev,
 	udelay(21);
 	feedthrough = b43_phy_read(dev, B43_PHY_LO_LEAKAGE);
 
-	/* This is a good place to check if we need to relax a bit,
+	/* This is a good place to check if we need to relax a bit
 	 * as this is the main function called regularly
-	 * in the LO calibration. */
-	cond_resched();
+	 * in the L0 calibration. */
+	cond_resched_stall();
 
 	return feedthrough;
 }
diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index 8c28a9250cd1..44f5920ab6ff 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -768,7 +768,6 @@ void b43_pio_rx(struct b43_pio_rxqueue *q)
 		stop = !pio_rx_frame(q);
 		if (stop)
 			break;
-		cond_resched();
 		if (WARN_ON_ONCE(++count > 10000))
 			break;
 	}
diff --git a/drivers/net/wireless/broadcom/b43legacy/phy.c b/drivers/net/wireless/broadcom/b43legacy/phy.c
index c1395e622759..d6d2cf2a38fe 100644
--- a/drivers/net/wireless/broadcom/b43legacy/phy.c
+++ b/drivers/net/wireless/broadcom/b43legacy/phy.c
@@ -1113,7 +1113,6 @@ static u16 b43legacy_phy_lo_b_r15_loop(struct b43legacy_wldev *dev)
 		ret += b43legacy_phy_read(dev, 0x002C);
 	}
 	local_irq_restore(flags);
-	cond_resched();
 
 	return ret;
 }
@@ -1242,7 +1241,6 @@ u16 b43legacy_phy_lo_g_deviation_subval(struct b43legacy_wldev *dev,
 	}
 	ret = b43legacy_phy_read(dev, 0x002D);
 	local_irq_restore(flags);
-	cond_resched();
 
 	return ret;
 }
@@ -1580,7 +1578,6 @@ void b43legacy_phy_lo_g_measure(struct b43legacy_wldev *dev)
 			b43legacy_radio_write16(dev, 0x43, i);
 			b43legacy_radio_write16(dev, 0x52, phy->txctl2);
 			udelay(10);
-			cond_resched();
 
 			b43legacy_phy_set_baseband_attenuation(dev, j * 2);
 
@@ -1631,7 +1628,6 @@ void b43legacy_phy_lo_g_measure(struct b43legacy_wldev *dev)
 					      phy->txctl2
 					      | (3/*txctl1*/ << 4));
 			udelay(10);
-			cond_resched();
 
 			b43legacy_phy_set_baseband_attenuation(dev, j * 2);
 
@@ -1654,7 +1650,6 @@ void b43legacy_phy_lo_g_measure(struct b43legacy_wldev *dev)
 		b43legacy_phy_write(dev, 0x0812, (r27 << 8) | 0xA2);
 		udelay(2);
 		b43legacy_phy_write(dev, 0x0812, (r27 << 8) | 0xA3);
-		cond_resched();
 	} else
 		b43legacy_phy_write(dev, 0x0015, r27 | 0xEFA0);
 	b43legacy_phy_lo_adjust(dev, is_initializing);
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 2a90bb24ba77..3cc5476c529d 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -3979,7 +3979,6 @@ static int brcmf_cfg80211_sched_scan_stop(struct wiphy *wiphy,
 static __always_inline void brcmf_delay(u32 ms)
 {
 	if (ms < 1000 / HZ) {
-		cond_resched();
 		mdelay(ms);
 	} else {
 		msleep(ms);
diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index dbd13f7aa3e6..f15a55138dd9 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -3988,8 +3988,6 @@ static u16 issuecommand(struct airo_info *ai, Cmd *pCmd, Resp *pRsp,
 		if ((IN4500(ai, COMMAND)) == pCmd->cmd)
 			// PC4500 didn't notice command, try again
 			OUT4500(ai, COMMAND, pCmd->cmd);
-		if (may_sleep && (max_tries & 255) == 0)
-			cond_resched();
 	}
 
 	if (max_tries == -1) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 198933f853c5..9ab63ff0b6aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2309,8 +2309,6 @@ static int iwl_trans_pcie_read_mem(struct iwl_trans *trans, u32 addr,
 			}
 			iwl_trans_release_nic_access(trans);
 
-			if (resched)
-				cond_resched();
 		} else {
 			return -EBUSY;
 		}
diff --git a/drivers/net/wireless/marvell/mwl8k.c b/drivers/net/wireless/marvell/mwl8k.c
index 13bcb123d122..9b4341da3163 100644
--- a/drivers/net/wireless/marvell/mwl8k.c
+++ b/drivers/net/wireless/marvell/mwl8k.c
@@ -632,7 +632,6 @@ mwl8k_send_fw_load_cmd(struct mwl8k_priv *priv, void *data, int length)
 				break;
 			}
 		}
-		cond_resched();
 		udelay(1);
 	} while (--loops);
 
@@ -795,7 +794,6 @@ static int mwl8k_load_firmware(struct ieee80211_hw *hw)
 			break;
 		}
 
-		cond_resched();
 		udelay(1);
 	} while (--loops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index fc76c66ff1a5..54ffe67d1365 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -130,7 +130,6 @@ int __mt76_worker_fn(void *ptr)
 		set_bit(MT76_WORKER_RUNNING, &w->state);
 		set_current_state(TASK_RUNNING);
 		w->fn(w);
-		cond_resched();
 		clear_bit(MT76_WORKER_RUNNING, &w->state);
 	}
 
diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index 3f72ae943b29..d8aaf476f25d 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -400,7 +400,7 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		/* Do not hog the CPU if rx buffers are consumed faster than
 		 * queued (unlikely).
 		 */
-		cond_resched();
+		cond_resched_stall();
 	}
 
 	/* If we're still starved of rx buffers, reschedule later */
diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
index 8dab025a088a..52420b1f3669 100644
--- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
+++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_tx.c
@@ -423,7 +423,6 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 		drb_send_cnt = t7xx_txq_burst_send_skb(txq);
 		if (drb_send_cnt <= 0) {
 			usleep_range(10, 20);
-			cond_resched();
 			continue;
 		}
 
@@ -437,8 +436,6 @@ static void t7xx_do_tx_hw_push(struct dpmaif_ctrl *dpmaif_ctrl)
 
 		t7xx_dpmaif_ul_update_hw_drb_cnt(&dpmaif_ctrl->hw_info, txq->index,
 						 drb_send_cnt * DPMAIF_UL_DRB_SIZE_WORD);
-
-		cond_resched();
 	} while (!t7xx_tx_lists_are_all_empty(dpmaif_ctrl) && !kthread_should_stop() &&
 		 (dpmaif_ctrl->state == DPMAIF_STATE_PWRON));
 }
diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
index 88f760a7cbc3..a540e95ba58f 100644
--- a/drivers/net/xen-netback/netback.c
+++ b/drivers/net/xen-netback/netback.c
@@ -1571,7 +1571,6 @@ int xenvif_dealloc_kthread(void *data)
 			break;
 
 		xenvif_tx_dealloc_action(queue);
-		cond_resched();
 	}
 
 	/* Unmap anything remaining*/
diff --git a/drivers/net/xen-netback/rx.c b/drivers/net/xen-netback/rx.c
index 0ba754ebc5ba..bccefaec5312 100644
--- a/drivers/net/xen-netback/rx.c
+++ b/drivers/net/xen-netback/rx.c
@@ -669,8 +669,6 @@ int xenvif_kthread_guest_rx(void *data)
 		 * slots.
 		 */
 		xenvif_rx_queue_drop_expired(queue);
-
-		cond_resched();
 	}
 
 	/* Bin any remaining skbs */
-- 
2.31.1


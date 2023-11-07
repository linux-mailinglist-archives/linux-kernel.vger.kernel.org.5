Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F0E7E4B4D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343975AbjKGWA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjKGWAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:00:37 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558C1730
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:59:38 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LJoBe000910;
        Tue, 7 Nov 2023 21:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=ZcgAHLg6hzjX72ZMxUiip8gq5zvpdyLYBHZBRJ5W448=;
 b=cllncWunkDmOrXibOlcJZyjRGv7sbhWNdwdvfIBl5Y/U20lb9JafeLfJFqp6070/5Zad
 XvCuZE2+Babh+puODb/UMu+OwiRA1ipUQ1WBgr6PWD+M5OC4+hJ7GZd5fzKlQcVtzVe9
 /v6FWiFYEVyuE5aOV1WRXju8D5aYExr71kYKmMhQ+NLgfdEN2mjJ7c5Kqtj/x/7GyXnS
 ui1latzP9Ayq0Kja3biM7a9ehrVxG7eRQ65HwPWUZrDMGkHk7N8y12Re1dV+t8krxqs4
 rhWnoS5hwH0TtOwkNG9uUq25kiXESB4t4rEQhOGjBtmNA8whTmC3WrV+PCyxugKxD5wg gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w23g2b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7LIsFc003945;
        Tue, 7 Nov 2023 21:58:41 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1vshv7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 21:58:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MidSblmpioVxYIdiB9HynhZsI/PfjYpelnD+yPjTPWlJXFnn3oJCjDbyXnamv36uIUNhMJi/9G10diXigBKqRVYSbKD9eIwJrKiEeUe4mcXUq1VXM60UpR3KvuyC+hXadaTpmUm82PTBHIwbkOEFwCHl4vcQ5cJbTKo0GLR705y7Z++PS+j/Xa9APXGIGmHisfx78LlgQGxpT+1IfuhTOb0srHLZ0dbsqvQ2jDvTCLRko7/fNY0oohj4RvgZI2hmiqOyDbKx9f1+C8Mly+jGVyXyCKhCyDALdNpsyj+G3MsjEpuTx357G72I0VZqO0F0bP+nQ/Qo3gFPVVMtdn5pCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcgAHLg6hzjX72ZMxUiip8gq5zvpdyLYBHZBRJ5W448=;
 b=Ab0F9uSy7IcZQf/XPgZxZkZ/8uiMse/sR2ZCqDcMrLd4h026sohU56DEQJWKJDGEejqajxzXM6Bh4LgOyFVz+3Ub9sUN91rfJBENKhRrDsGOKorH7I8CM37KRjnZ0gYbjvtWA2ul1d+3JlRllwqHo/WrwSyHltmAEiYr3vJs5cDD83Sxifbls0oGAuIBfrnbmT5n2PzV/lDAWzb+djbPAC+Q7BdWuV1TG/3XS2FtAOwO7FtFdNIN0hoAXT007Zc2D9busW7vEynX7Sib4ptfYypfc39ZCDbV9A8MtReoYWlGuMJd3up5ZPLBaR+7A5Bu2jChaYJp3b3dkcnXqNfpKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcgAHLg6hzjX72ZMxUiip8gq5zvpdyLYBHZBRJ5W448=;
 b=EFmNyBak4qPlEPfq5B6McLPaOo5e/qRsOQsORF2XrDzG8WL8QvJkP3/HgqCEMiXARHof+kkuW2jJBXVebfnfWKC/PTtB7if2VBfUy5QvHoTFE8oLWJlmuFPWCieoL0dYbP1ypcomvIpzqwkxUcO6U6z+hNUVJeImiue+8R3PqkU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5048.namprd10.prod.outlook.com (2603:10b6:408:117::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 21:58:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::1ce3:4a8c:4c99:acea%7]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 21:58:38 +0000
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
Subject: [RFC PATCH 18/86] Revert "preempt/dynamic: Fix typo in macro conditional statement"
Date:   Tue,  7 Nov 2023 13:57:04 -0800
Message-Id: <20231107215742.363031-19-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231107215742.363031-1-ankur.a.arora@oracle.com>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0006.namprd16.prod.outlook.com (2603:10b6:907::19)
 To CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: b65ea8a3-1408-4899-b058-08dbdfdcb278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/igqcYhRa2pMjgy3MzRuzzNiDX0ZMGEKQxHUqjVwZS3NqtMEnN4gAOWurMHPggqRJjmp4HtkLL16oh1OcI2rbGLv9Xj0Qv9s+BuYtXpePXNf5J1fVV8zth2ioXamPzqpQRLCH7rQJ5dyqA9eY4cLl97R6WlkcH9fthtS0WfXcAcy9TpEnq/hiGzxU3icmNGMS1ue/gMDiishPmF0wI48qhq4PKG0U2nfSSu1cK210AmlMXv3W3GQSJfqeuMFUiTBIxXBaacrGB0JtXA+zECcF2fFoMbnEJ7nbsnNlXAFtyob9omEkrlp6fLrfIL4j6JTlc/9VnCHg7uucWKuQX+krM5tJay3ocbNrGJzRfu3EvkdiecAOunuC4mtRZqKazAMF3s2o+Ox8mv6ro3yy6sv/CBxbi42phOUaLUH1u+OCpOgrjIc+CDD2ZSkVScOnQYDeKMD+Y/hGnIoSn2TWW1k7KksaQCkPvZ9PrfTup7L8dmVmyQ7extmXtJ5ugBbxFxpitHd9tKmqL0snQ96GxRE/493NJjDOmZtAX0XBeA0nxQwjHTnCEQdonsFXSuItZP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(8936002)(4326008)(8676002)(66476007)(66556008)(316002)(6916009)(66946007)(41300700001)(103116003)(2906002)(86362001)(7406005)(4744005)(7416002)(5660300002)(83380400001)(107886003)(2616005)(26005)(1076003)(38100700002)(36756003)(478600001)(6512007)(6486002)(6666004)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iwlx03yOylhLV5SrVAotUbZlATjudllP9wqnWCJNFpbzOEsGNJiQBIfiL3Gz?=
 =?us-ascii?Q?3L0y4uCZ1MNIE9e4EePu6RDk3oGGk94pJW1n/4bY/5u85Qb7G1+v5apFZSFu?=
 =?us-ascii?Q?j8v+2xFtOQTYFTGvVT2t0UQtmaLk3UD6x7iERt39zYxVkIEN7blsNBzLZV4W?=
 =?us-ascii?Q?wYFmL4EulE42kskKgux622qZUg5vRDhRel3yubNnyLjaidWKfe4Fcd56AbXP?=
 =?us-ascii?Q?Q1QtqacOWN6ZXWntTSFaLZIEnYFh+uPJkkyR7xKYG2C5h/blTBNArabyWbOg?=
 =?us-ascii?Q?DC6oHaHfWvrzQn4Jf2fmyqQ40mguO5cmZQo8pIjpprZD5txskTOgBC04WQ/D?=
 =?us-ascii?Q?98Ta3AfP4dWIGTPwSkrPU+dQ0RD/qFH8eHDbS/jifnbly+wg2ufP1WXdGFUl?=
 =?us-ascii?Q?5lKCx+ogna5q3HrIpk4yZeBvXwfe4wAABPODRFRsYbNWYxcfi493/yQtSdWo?=
 =?us-ascii?Q?OtuEr5BwJzfhIptNFXoKgNshgaZqMl53JK5FxgOOVDGqX8TOYp2iryeWp3z8?=
 =?us-ascii?Q?AK02hAKBjxxxksrqcZiK7lpVmsSzrPZ6HKqDATkhJQ866tW6T2grTaK1tUzJ?=
 =?us-ascii?Q?VLjlRGFsOHyAAfzot9d7gEV7pOU1tBk26MMQNqfBSFvb/N9BKSF37uKfGlod?=
 =?us-ascii?Q?M53DIkR2gjVSrxVcF0ASUtw7ulmk6JaQIzp54/8xIcg+2jhyUcV5rT4jN8Cy?=
 =?us-ascii?Q?Ov16KijPVUQ2MpuZIKscArmmRYTUlamEMflRXBaOtDBzlZB0aKARGZBWYF/H?=
 =?us-ascii?Q?4QVGNLdV/AIIvGyU/bK+sDxoTdaC63zwWnsNIAqIwQiqB4dUlTokwI7UuvDE?=
 =?us-ascii?Q?lb+dsD+c4mR/CGUEA7TJDXjieHzKKul+AiE8gubKWVaCk+Sab4MllnraZ+i+?=
 =?us-ascii?Q?TYu/iqzUokEIiPmUhHgOWweYT268TK5+nJopCIlYjY7m3mOaS6IIsQh21EUu?=
 =?us-ascii?Q?0TFdk481w5z6vqxBfx6JDix7NiWzWSIU1XKxV+eF+jBceg9mtkiV5SE+gPLP?=
 =?us-ascii?Q?OW6XO11P5Ud7jLKU3VSvwzFm5erk6FGBN4iFY7QuAQqBzbiLFpa59lkjnAXs?=
 =?us-ascii?Q?xXYIUbXQxWMUQPxtwK4BpTzajD3WCcX0d5l90QJBqcQmbIZETkgbtMe3tXst?=
 =?us-ascii?Q?tSPcNgROp8FOJVMuiSdeSGVCF0VQx5Xs7zCIV8H79tpwt17+YYBsmHTz5cxs?=
 =?us-ascii?Q?v1wWsClC8V1A6up6297NLOYjQhZ7W/0w1qfzYyF4TH38uyb6j9NGs7RDZk/t?=
 =?us-ascii?Q?5gfjLtnrWkLoJdxibZRdnTCpzy7i6R1NMtO02gJxoMEieTprEvTsW3aoM9Pp?=
 =?us-ascii?Q?mOfEKD0lWY2nDlTRGydcBbTt/zmBqkXh9RX/w3i7hP5zd1hmQ6wYmnj4Y8/U?=
 =?us-ascii?Q?tgOX5IZ6fTc9KBCcnJXBM9n1ni7adZckiCXSnT0lnQ9iprGHK2dXMnJjXBDv?=
 =?us-ascii?Q?PulZ4FkG5daOpg64A4bqHk90eYhuiB7b5ME3kHhVDShcYgNeVZ/CaJxhPmNr?=
 =?us-ascii?Q?UxQ4RZovbr6y5i0YdKI75B6dbD+BhOxvPkaQVCIJy6KbYAA8Hs+SIMabLOtD?=
 =?us-ascii?Q?WZa4pVjkPNZsbm+asH2w+cFMpFsJR0FO40S1XHFZz6DGKT+V6tXiOBwF6PGK?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?WuGJ5idlBgSSzrPk+c3yDGhG39DsRP6o+JgG8OkwLldsVt3Qw2rH/WsTb0mZ?=
 =?us-ascii?Q?6GFc7qtWvFa/TVr3+qPRWZhM8+dPLQIW5kG3HdaUUKzZJspm527deK6/5rdw?=
 =?us-ascii?Q?FBYk7XXJayBKMvPQf9txHDh2286FaStolSuwxO/nLmWIHgkdUOC08qxjJYgB?=
 =?us-ascii?Q?AjBiqZXq4ylXIrX2mqSk33OFzOPvr9yySJnByQtWrpdQPcR51UKhDjdcuMco?=
 =?us-ascii?Q?xdVcUf/E9up1EkGXC3MAyZaSfkPtebyGfRwGoJwTF85zCtGo90rqyi9J+k1W?=
 =?us-ascii?Q?1a97sqt3cZ9xAJvab4UDjQlGMaK0ZyM8ubby5RzZP9dO2pDXQ/SMV8ujuMXU?=
 =?us-ascii?Q?2MDLwcKMyHPkWGB3PEWPgCkhiFxCFvJsQNSGpZaA5VG70ATt6OtkRgvus/fd?=
 =?us-ascii?Q?oAp8M/+GWc64kxmfyomK//Z9uk1bUsQ5lhoEpKViEt23JqykaQDzhW6/77L8?=
 =?us-ascii?Q?7drM7pnXVbsk2pwRYXJ6OQ7Sy2LoLr6XDts5IGNJsZTcQHxRZvyK01C7tyck?=
 =?us-ascii?Q?+XT08NzhJhPJ3Mfk2HHxp5ybBfN0HfLpMg9grCi46K/I1eYf3Bv/hmSLOcxY?=
 =?us-ascii?Q?fFZHjb1rXOC57vLFlP4s2ZFamuuGTNd96wukZaswk8itx1PPCKWtPPRrYoCE?=
 =?us-ascii?Q?ns8fQ60peNbH6KTn50EyHfcXbGRggVpadZgW3G2rZutdZTWv1RePKuu9SEgL?=
 =?us-ascii?Q?mGk1tSnJ2LrmNvYpUWwSjOjua0qhwqrnmUmSzaaSsCtheAhSUUfkcN3kIzwK?=
 =?us-ascii?Q?rIdHICGpcYDSi/9hsj2vsQ7nyAKgfjbT82taHcH6aoW+9C4DmjrSEzpyBQtf?=
 =?us-ascii?Q?n3T2rSZuCJxa2Xwbsh/FBJZQdn86qpdVeO7k5e08IvyyGwvvH4WBQ0ikYzw0?=
 =?us-ascii?Q?svQexmIUKhOONjd8cusrNuOIM5RkCIUEjAw8u7A7gMqyrgdm3LEdSqa+mSzv?=
 =?us-ascii?Q?e62FGsUP13hbuh7NuaVpk+jzVWDgHmIVBCsBjH5sSvgUEySwaWYARCPk75bl?=
 =?us-ascii?Q?Mzxu/RjC0G+Armca4MEv31fJXq2wnpt4uhDs9kRdSU1+vgA9h4V2j9mFoVIy?=
 =?us-ascii?Q?8E3AdX5ma0waeDrvj1mE9OaDi5Gae/ZE6nvPPh+T+8zZ2DdpAvv5h7wTpf5K?=
 =?us-ascii?Q?dKWuqGzg4AvsJK0PvoDlvDUHpQ8HMWVcGKaMheZlA+H14QBqU3tzGD6pRZxB?=
 =?us-ascii?Q?4O9nZIZYi3UotmnDCf9zLCWCEXsdjeKzFkyANWNKndAojbtO4QLEeqh9Q5LK?=
 =?us-ascii?Q?RtnFcFF7IojrYOqrRhEYYp7zlVWf4G65I3StjFdnxodEkb/AqsXf6laq6bTN?=
 =?us-ascii?Q?d1LiymtQrJ1OMJmIDcM5XFbPOmi3Gg8kOIezWINus9MAgMnO0lBIA2EVJY7o?=
 =?us-ascii?Q?p83ehuqki9inb7OAe0AdY38ErEOQPyAGEhbQYl2seU+/2oSkjfL+EY7LkGHK?=
 =?us-ascii?Q?uLSMRE/5/EyuKBQjkxtKtGkQDIChhrQbyh4JpGA4brB8f3EA29BD5SIsgQvf?=
 =?us-ascii?Q?KxUP8gkm8dy2vDCnSJNdS3SkV1m+USDkava8TPmWqPio7nSYGFUmDDq1EA?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65ea8a3-1408-4899-b058-08dbdfdcb278
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 21:58:38.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xr2An5sjFfFRl+AbIVsTaO8soe2hUO7/lSO9nMswXa6levGx9WoL1HaTrDbot9qfhkwIv7SpcAwHOBxtTQ5nJVfhdFgXf8ZfUWJhgmtJvE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_13,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=990 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311070182
X-Proofpoint-ORIG-GUID: 1X_lREiIyBoE68AD9CmShD6U3C17-FXO
X-Proofpoint-GUID: 1X_lREiIyBoE68AD9CmShD6U3C17-FXO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0c89d87d1d43d9fa268d1dc489518564d58bf497.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index b0b7be0705e0..d866c49dc015 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -418,7 +418,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 
 		instrumentation_begin();
 		if (IS_ENABLED(CONFIG_PREEMPTION)) {
-#ifdef CONFIG_PREEMPT_DYNAMIC
+#ifdef CONFIG_PREEMT_DYNAMIC
 			static_call(irqentry_exit_cond_resched)();
 #else
 			irqentry_exit_cond_resched();
-- 
2.31.1


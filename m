Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A077DFB84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 21:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjKBU1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 16:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjKBU1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 16:27:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03381182;
        Thu,  2 Nov 2023 13:27:27 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2JL2ar006106;
        Thu, 2 Nov 2023 20:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=/5HeeMOj6MQR+DU0KP56V/JLon76FGUWez1TM6HLNCw=;
 b=my7pul1RPxmQG8VTvAYrH72tDi8r7poHo/d24qTJA1y9pClOsmBzyOQRzCgZx78EjVL1
 hWEwIR2Q1Hf9rp+I1ua6EkEduw0STHXzlI5GqAikmMHJy2HtOJfOY+pWUsA5Ujy6iPFV
 0Tt6QUlHzbRvZ25A4ciksqop0B9BVCqcC7+8fTbkXAIXlVJfjKa1HWrCN4eFpb6z5p7u
 cEqDwdC6OKhlw7iLeGqzHRvGR7G6exBukUbSVx9C1Tom09gegPPaBd6xhTXB5e116Qzx
 MYege59ZsLpkEzttzM6reAFDPKVyAzxu4KVH0QJSYQGBpYYudD5vfXbKv4d2DSvXdHFU iQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0swttt0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 20:27:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2KK9OF020068;
        Thu, 2 Nov 2023 20:27:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr963a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Nov 2023 20:27:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOZ9JvSgokje0Jdc+VwaWJ0w5XFcOO1QKk2UnVak5xsTG59hlVX1YKzdmIPE4jkOj061rhvFNBWlZIoxEjDM4Q9I+LIgEd+S2V7RX6gH6cO0Bsk3Z8L237ihQv/bEF7MeG9WB7dqJG/5CSKSIlsGw8v8M3Nan/aAf6K1hwKI+E0tAqnd3sBDPJYVrYzid5FPgc6uM2nUGPDCAIiIzp+73a8aW/xFPyoQ0EAcvw+kQ79VK4Y5P3/hNhoFujMgTJYTj0FkSloyOzHuvvPpOPlH/aY6Rr6S0aJZbomdeMCB9mpbGvCgDdgtsBVaJtBXIicktz30R1yD9Rl9cATunxDAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5HeeMOj6MQR+DU0KP56V/JLon76FGUWez1TM6HLNCw=;
 b=MeuwARZ+Df7aE1f3WUUMbMzFbp5fTUbJlkSyuvC39BTqndvP7VV+K7HohSQLBwE/Hr8iMdJnHErIx4Vu+G9ecBTaRmJgKyJNfvHRG0q3AcMA44ZIeH7gB40B/aEwfKM77JQcH9vdmFoFUrmWUXSrf7LWWQ5KReUdGfVrvpmlm+gaegwe7Z7tNoDgDdkC0a1EG5t8NrMvEziHs+fpdUO8NJWluuBzXcDJ9IRyiaYFUlpuplyo1fX5/Ju8uHqA/UiA8K6YEDPvFxCh3aaSqYOaH+T9lOmlSk+tNZ5Vf/e7lF8n8d1Hk1VK9LxCyUbQVBhMbsvVISbY+QLkrVclGAXhKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5HeeMOj6MQR+DU0KP56V/JLon76FGUWez1TM6HLNCw=;
 b=yBW9Jwbcru1UOTmqe5969wIeQhtpKoRJ63/UmZlY8AHNBCP1U2pPnA15tPZpFhhRci7tO+ac/SExPXF+Ql3MYJp9J2RjhRGL4nPpxr8z6zMhq7g4YrWnH63k5/a0JyAVCmsfKfSFEfiKtYBSUOYclku8CN5rAa9zWm2x16ojNMI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Thu, 2 Nov
 2023 20:27:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Thu, 2 Nov 2023
 20:27:04 +0000
Date:   Thu, 2 Nov 2023 16:27:00 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, stable@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 02/21] binder: fix use-after-free in shinker's callback
Message-ID: <20231102202700.7mqahdkstuorydfx@revolver>
References: <20231102185934.773885-1-cmllamas@google.com>
 <20231102185934.773885-3-cmllamas@google.com>
 <20231102192051.innr2tbugspgmotw@revolver>
 <ZUQCBnPYf_fzlWnD@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUQCBnPYf_fzlWnD@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0399.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 129bb35d-f8e1-4f48-2311-08dbdbe21360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6WgSJcX7Oj+pVM4YpaCydMtx3b3n7HVNPoBbzTOOt3MFkYGRrL3bDLLVPGmV9+DDPI4U0L7JyPLHibEqIu6birswFGqopTpmeM0MUnr/KCLl5VezseNab0JAEuKCxGzgeJVZPFbSnObCvdghxcaz7p/uArb5eeQjHGet/ILk96v7KlOOOX8ps6j4Jk7WSYLHtDcN9qVJzyshntbumYFJQ/cl90SrXWWAr0NNC1IaZNSDBDlb9Enr6Bp5/eCbma1Cs2bvhOau/hBCWJPwgNw1Ou7h6IY+6uYMYbqqZD4v1DbXEyJnRIhBAoX6Vdj4BCNZAvmPNT08NIh1VLgi5tXKyOcNlEWCKTWfdogJNMhQDPtqQjIFpm2JP/EjRbPP27RDGbpy3zKFVZ18WmBa9U/OiMmJdVJ9f/e8neAeXbDwBMNYFDvu4qJ1HfoF5fByDm/+N4xswnEvcK6fd1w1ts8wJpXErltgKbx3cGgQrKBGU2K43Tv9hsYVPsFDtQvMg7kg7zGQulMR8T8/WDfGV2BoS1G0RjIskgDNEVj9pJUWUy4sKG0gciItdrePp92U9lSB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(54906003)(66476007)(66556008)(8936002)(66946007)(8676002)(5660300002)(316002)(6916009)(4326008)(2906002)(7416002)(6666004)(478600001)(9686003)(6512007)(1076003)(41300700001)(26005)(6506007)(83380400001)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Db2MgH3nRYQrqZK/94aBPNuWu22q7rELq0AlIW8a6w2XBKXdSdHTY/CSYAmv?=
 =?us-ascii?Q?eD4NuPfsNfOiNYDuQdQNqz5Ya1oWMNNNgIgwUAZWsmfdnCRPOKCsJSKRg0Jr?=
 =?us-ascii?Q?nRhJKyqIYlgvg4IDO6UT1XOyrfzIWZgb/Ab1r9Hi/uI54uhDPE/WaxYRPuvS?=
 =?us-ascii?Q?deiaWD13nZ3+s6x69HqQvagJCgJCRHc4ftXENPtRj0FK0TvfKP6K65Ms/Y/t?=
 =?us-ascii?Q?EpeArkgpEOfNQ0Km2UmfjZGDXTrwXVfmJX/mPyZgZtNXeFHcqb1GVNuFrIZt?=
 =?us-ascii?Q?zkcVeeOKob/38Vs2sqF7DA0HXXN2ZOoTFDqoyjLxwsJI80qTVyQaS+kqzZRQ?=
 =?us-ascii?Q?UTLidcUPIthPnxPnzMMN83625PCsJCTSFSxhufQl+GuH3pko9iml/1zqQ2Xu?=
 =?us-ascii?Q?uhMiyEJSpnYEyL/sgOkuLbxUSroLljuhwHZxUQRNHvumhvhVo/p4CXpQfltW?=
 =?us-ascii?Q?vhBwRIHnTDD8Yy7xb2SY1ceJ98NRi2iMbl/DyHx+dpbYplCenDHo4WYTk9hZ?=
 =?us-ascii?Q?v8fJTQJ47E72IW0BNnz6UDdIxvKbtwmI4qGZaYj1e4KBhxRWuu9ctBj2/m+7?=
 =?us-ascii?Q?xtA9LEZRsrSDoet68ZHHHr1HF/XTziHT4bGihqtjOKD6fhFVH4sM1/SYz3do?=
 =?us-ascii?Q?3dZA54tXtJWpt91E/QELYa31wx6Fi3kQwonAnRuKC/iI33aMwUbWBxfmQVGE?=
 =?us-ascii?Q?70ZJkqspZNj+WWRQElxmWcuOwpTNaBMgOklFlsw4zAfpaQBTJl46zVkHRJeu?=
 =?us-ascii?Q?uyaNTc4IN3272WLyJ9u0dsRApY/9LT8gEO7s0gUWyJhG4nLYen+dszTASKxm?=
 =?us-ascii?Q?CvEH8YDWruL4+KlXw93kOB0gUThyejx4KlekU2op6sIUhwQ3ssaJYkDNCOmc?=
 =?us-ascii?Q?CA2Ct1/Hpc5y8p692xv5TWOF8M0JNURFHFz77pJZ4JaYI5omso6lkdq9ONay?=
 =?us-ascii?Q?YzCaPuzGpsNj2nmT7jbYZpoFJm8KfVEC362W8z7tgs8dxh1NMXvy+MUF7xed?=
 =?us-ascii?Q?P7m1tCKPTLApDVt5KSI5h38QP4Zka/mgexP+b8XRhIEGoGVK2H9q5Dp7htZK?=
 =?us-ascii?Q?gkgsB2AK9RqwnIAql5uiNBd75LTrWdmqvH/wmt/knGEmyCGqJpOFVdi6Is+x?=
 =?us-ascii?Q?Vbfdq+GrTFzXBNuXbh960YKBZEerz2D/nArRUz3OzJQQOqHBYaEcOSKVXZLn?=
 =?us-ascii?Q?OTIShQpkboOxAIeZH94rRQKuo+03V071Ilp/Sg96MGnvUB7QCnQEEetJruAO?=
 =?us-ascii?Q?nYqhUgw7Vu1GrUH2VUrwGQrwFPI9jYUBUTIPtnShC20XXvBenFLBvNBOyuwo?=
 =?us-ascii?Q?9/TVblKZqfwoP5SMOHGUvOPBVul8gYUDR0ETUUtm06d/hA3p/A/aD1TCwKeK?=
 =?us-ascii?Q?x7M+Z+H8CLRmOY6nhRgPhHxq2hlhWfTRaKCwsaz9GzO64U2vJ/3Av027SrWu?=
 =?us-ascii?Q?HwcugWvdLsN5M9CvPidhIoH5DCR935DXgLYQaBWoLwh3161iBICRQrFcILkQ?=
 =?us-ascii?Q?4QTQ2BqWgNsNo2rWap5hbX/i388/K6fqmvUBfxBdTyZSRDWmyqJ91Y0CbO0M?=
 =?us-ascii?Q?jA27TDLAfgicV6DAeV3ExhNPhxuGN0K3vq4qMQtx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QWrGuqlnn5gQ6TL04gT7bx788dNaiSxmrepA7Hm1usV188H1rbkwEwwSyotE?=
 =?us-ascii?Q?3RoBbhOZL792SzargfyWy5mJpMrHTD3Ktv1xZGL7C3gyqUV37LTuBp7kN1rW?=
 =?us-ascii?Q?WjJ8b5jURmC8kkcsgLHrSNOkY6hIfd+d6M78Urj87fFHBztZx07cxHttDnbu?=
 =?us-ascii?Q?pDZasbvv2hCp7A1n6uA+EUJzXQLjmb105K8dxm+xsEoWnL/wnrn0n1TvBrnN?=
 =?us-ascii?Q?s5LvZgpIYy5DzHpENPUpvUO1n/HgqYFyilbll+FR9iEEV58wlvYW1TfHWOLt?=
 =?us-ascii?Q?Lgc+AfjKHtL+Np+8l7BDwFR1qWf9VtL6CLyk8naB6OPDdXYmiUREYuazr03n?=
 =?us-ascii?Q?vrRcXFMArTcSXfeoVKCUiygfO6jarxv/hhyG93O26+lZrdQPFafYsicMpvyM?=
 =?us-ascii?Q?wPlKsg08hW6vf5fchHXqD4SQYNb6OkfbEXP9SzAK1Lbtshyt7pNT1e5kyvxJ?=
 =?us-ascii?Q?4NbDEj3/+8NHZRRC1+62m80TnI/8PC48qPiyVA72RRrwEncaL6x+xMpZ7cxg?=
 =?us-ascii?Q?u5KgMFBxg/724YCj03qdGUFSGoYQefpnowNpB5J7zb+DOWvCadZD7gOWBBqV?=
 =?us-ascii?Q?MmjU6I847iMxUilhTD8nsLwnJWm0DexbH9vwxL5LsNPXPF7OAhIqY3WtG/ab?=
 =?us-ascii?Q?q2kFcfplf6WEb9QTnmldnVmvZWedb5MMuw5sbEOK02E466e2Jdf/k40sS1/4?=
 =?us-ascii?Q?zJZH8LkTplo8lGyjRzkqzG2mh71aRNwYRbYdj7GF4mZlRStLdoAuxLF+yNcp?=
 =?us-ascii?Q?sSyfnNQla5yR6c8UWEeHpVyG2dxAuqA/qjFblx2+7vHZa03HGAhx6ZbC6vJe?=
 =?us-ascii?Q?P3vq6QQD/K4aV0YCeqa1IOrBIAcvOPqiJve3UOM4574yj9Q9/QkLssfZTtpJ?=
 =?us-ascii?Q?GQaHHj3Eqxn1s6cRm4MIkRw8vY3TeUaI1a5+o3ZFZk7NQcIO/RNTkeqVsGX+?=
 =?us-ascii?Q?9+dtL1thOw2KCZQloESe7Xx8I+0Zvtb8milN23MgtAF3lT6xYGCcRZc34sgG?=
 =?us-ascii?Q?Q0NS2PYb2UgJjByw20Zj1zpIjM1fq3+uegFWuAAdyBU4NE96Oa5nsMw5Q4Wa?=
 =?us-ascii?Q?kfysTJlsvUsT9Mkwi0STkRmnw/oA1AEx45dEJcMHO9O4WP9GeH8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129bb35d-f8e1-4f48-2311-08dbdbe21360
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 20:27:03.9804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9/5wXsUsvGgsnzhPrvykag/hyLqernCnbe0eqaK+qNmFp/ScRReD1nNfgsI1pit+q/lUAJ9z7kQ/h/+CUg8oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-02_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=649 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311020166
X-Proofpoint-ORIG-GUID: AT4CY0BvCZHcVemfPvnpHdI-ov6bf9DJ
X-Proofpoint-GUID: AT4CY0BvCZHcVemfPvnpHdI-ov6bf9DJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Carlos Llamas <cmllamas@google.com> [231102 16:09]:

...
> 
> > > diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> > > index e3db8297095a..c4d60d81221b 100644
> > > --- a/drivers/android/binder_alloc.c
> > > +++ b/drivers/android/binder_alloc.c
> > > @@ -1005,7 +1005,9 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
> > >  		goto err_mmget;
> > >  	if (!mmap_read_trylock(mm))
> > >  		goto err_mmap_read_lock_failed;
> > > -	vma = binder_alloc_get_vma(alloc);
> > > +	vma = vma_lookup(mm, page_addr);
> > > +	if (vma && vma != binder_alloc_get_vma(alloc))
> > > +		goto err_invalid_vma;
> > 
> > Doesn't this need to be:
> > if (!vma || vma != binder_alloc_get_vma(alloc))
> > 
> > This way, we catch a different vma and a NULL vma.
> > 
> > Or even, just:
> > if (vma != binder_alloc_get_vma(alloc))
> > 
> > if the alloc vma cannot be NULL?
> > 
> 
> If the vma_lookup() is NULL then we still need to isolate and free the
> given binder page and we obviously skip the zap() in this case.

I would have thought if there was no VMA, then the entire process could
be avoided.  Thanks for clarifying.

> 
> However, if we receive a random unexpected vma because of a corrupted
> address or similar, then the whole process is skipped.
> 
> Thus, why we use the check above.
> 
> --
> Carlos Llamas

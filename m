Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C02780D1C7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344598AbjLKQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343939AbjLKQbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:31:01 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC38895;
        Mon, 11 Dec 2023 08:31:07 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBDbA6a026410;
        Mon, 11 Dec 2023 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=VbJmTiRB8QQ/sXq6+eI6NCJcZbWP8fDqogy1PpOe0kE=;
 b=AXMQ3B+4xIh69E2rW9WqtlFZDl69DDBzozP1JyQm2GBEWUBXJnxeQ+x+y8dzQxkdbZRw
 1rD/TtyCKJ8TasMew46FThBVEzBYtz4fW9dA2mhH9sqf5r+XfjF2vCpqDNDkeOdy/Uji
 ItuiDN1403qShkhlk/jeyRfwPYTjEmJmrJIF+NwC06vlH61+p7ffZTmhXCvJ59hjwv6s
 DjkrZtX/zC7Nw2OjlqVm+zf002i3eDdhUvO4m/6KN9iePcfVbI2RSOWLuJ5BOvWXdlnb
 7LSP69PE7L4uxe1M41/SvzMVeqT4Nkfbo4pTg36mDYda07o7Gvyize+VqZDwOjlGJEw9 vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu3d63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 16:30:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBGHRP8018613;
        Mon, 11 Dec 2023 16:30:52 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep564jd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 16:30:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbryiIZzhbVdWNhx28Wuuk53AOXYobGgzA46f/3m79ISh1r0+Q0rbEOdKRkO0WXOyWk41Hq7iWpsmJM8ijIYxTdqSHLw9phT0MWwqWp5yMDbr802PVCvdFVM2QNjLmAJVobeNUD3Yk8iGVwfuI0u66SHh9e+RjWeYSkFQexDZS4+JaFtzc07KQDW4uc1UygJ/cTG85BTOmyFCa4lOcvx9np4pXRYxYUf1M88A8bzc/qJ767piwakpVVi8xyizFV021ZnqVb1NVfF2U5mXASDBwWTSYL3qgWn5oMdBhA3+/vHoqZKimKXlkLwWu0+MJpYlPXhi2hJOjsFqXPXODt6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbJmTiRB8QQ/sXq6+eI6NCJcZbWP8fDqogy1PpOe0kE=;
 b=X3zg6WxN42wuOW1SU6QoCoxeyrR1rkqAwR7Oaal3LplZVrOvOkzqprysf2D7UWzoyhTQDPg1sBBqd0dcIw7lnn/ynZYF80ij1/CEs5pUFPY/mSXeG5JmYk82esBLBrpMxQAIJPUr1DhA7FXv6D6tqQFLqfJL7gdIkMdLKMEUE4EQGPmot/e5A5ULP0ZtTO1El7r8J7kUPqtO3zb38ihQ6UPOs4rvEhGe7hzew1TlNy9bPZHdhHTbaWMRGkIeB3mTdzRlpu4nEGWP64uoK+fz98v6g5EuTza6kYXgNXdEU3IT/vD1huARuykisyshT0jDvGQQhQuWiEb16V8SripWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbJmTiRB8QQ/sXq6+eI6NCJcZbWP8fDqogy1PpOe0kE=;
 b=KtkRnyxWOGcFvDVyB4n9qFJA5/V0F2rW9XFA4Vz2PqvRONdoIHl8kjnPUACTpbX3Vq6NW2V53DxJXkjZtefugErVm3D4RqPbNUJ8RJc6kemxjJTdvfLs70hZXfvi2rVIdFJr2A6xdlD42P7rDGFChINwu4/oH+6+E/wP2M7vAd0=
Received: from SN6PR10MB2975.namprd10.prod.outlook.com (2603:10b6:805:d2::10)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 16:30:49 +0000
Received: from SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0]) by SN6PR10MB2975.namprd10.prod.outlook.com
 ([fe80::de47:3c1f:a55b:58d0%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:30:49 +0000
Date:   Mon, 11 Dec 2023 11:29:54 -0500
From:   Kris Van Hees <kris.van.hees@oracle.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Kris Van Hees <kris.van.hees@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH 2/6] module: add CONFIG_BUILTIN_RANGES option
Message-ID: <ZXcntGeMdn0/1V9F@oracle.com>
References: <20231208050752.2787575-1-kris.van.hees@oracle.com>
 <20231208050752.2787575-3-kris.van.hees@oracle.com>
 <20231209075917.833c8f1ae78172dbb1d83b97@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209075917.833c8f1ae78172dbb1d83b97@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To SN6PR10MB2975.namprd10.prod.outlook.com
 (2603:10b6:805:d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB2975:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: f4288093-48c9-4ca4-1484-08dbfa6688e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bQPIzTSfyop8cXC/2ugTvm+arATD0JJJIsWHJbSCWp80uH7uKeMk+bIUS+Vouq+sYT9S/NdMxAqjqmwn0zkAV5ChnxQFPs8Pwty/eXr2Vy8DRqgOD23sld7Nbo5CRiuPsZHfd48bgHWvm0VTlo78fRGApkvks9ZvqeAYwYuo5gI9EQPtnb9ND/yBq1betNEaMZCpwDG50n6lY2FIA2xhyg6Y1H8vSOa4kRRpVRzsDF+sAwcF8eKa06k2lkILvXkxEC71cCIYNwDl246AZtj4QNYiWQnUl3Z+5YdMjcqZLL29zW8e8fYvy7Y3w0dMTyPnNI5Zr2zu0u4rI61TDB1zGde9OsA/vUB3+EGA+8W0fb3qt2XQVGjpBfT3IoQdRMf1ho7oDCHIqRRT9/+GYK3sf/qrA87ULMexK4vOd0mZytXgLXDSpNqZbjFSO2yqsjh3DCUbyVnXvaR73itdYIldy/5U3cey3rOAaqYpZQgZc5svioVnj1M5+Jn40juVxl536o+sLneQhwX9uxKVgo52LyO+7putxbWOl0/eMCLcbWdoQuKEJmVkyeUcleK2pkj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2975.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(6506007)(6512007)(6486002)(36756003)(6666004)(478600001)(316002)(66556008)(66476007)(6916009)(54906003)(66946007)(86362001)(8676002)(4326008)(38100700002)(8936002)(26005)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iHyc/pEEHJrSfYWcJGhj1Cni82CUub56Vr7STKmsJXvcQQXwzRXamMEZEs8s?=
 =?us-ascii?Q?+OES8b8yYDiyUrw9tdMRjZTmWc8+M6ALJmTSKQ0R5zLO9nAG95K5fOovdc+O?=
 =?us-ascii?Q?f9ev3y3KvOmYwRqxtURy4rnEXvSpoHUzdxbyzb1vP43BxEbX8GVBbJXlOeG5?=
 =?us-ascii?Q?t4LLk9LMQcOaf1UU8vh097+jYfGgH3R46tFTTtDUSkXXMvYhoaK04qo6hXah?=
 =?us-ascii?Q?YNm8eskC+Van21HDQRyOs7y2+t1A9aU5sDUTaOkX7Dps4xwJWFcajjfVmWmc?=
 =?us-ascii?Q?rhw2A2WseR5GYRP69oQk9KpQ5w+4ausivKKpfW0RJh5o/RIHwGgOr2myhISY?=
 =?us-ascii?Q?qGnC0KAt4AFCk6YtUh8jVyU2XXDo7Z7aaou7jJNNQhMNBVnw/M8auk7PR6UQ?=
 =?us-ascii?Q?lciRooSSNYf6/6nvmRUphJgt/zY4ygnD6eYC3rhX1x6vZC8S/6TRCbBUeLou?=
 =?us-ascii?Q?pbAd/kVkFnlV7f+hAhMd6bGp12+ahcirIwuKyWJO52K2hsbX+KCwKOwALEmz?=
 =?us-ascii?Q?G066QRsLsiCAlKL1SE8SJbXT+RIx3J/mUAAdyrETAcoroouaTMUFp1iThxHm?=
 =?us-ascii?Q?+jlAR9gBK1v3wlZ3OLnVxeKBg9G/A1QQsNkwbM2wzV2wBV7TsFNS18kKDzD2?=
 =?us-ascii?Q?D4xx3hFPghgdRB9HSLrrEmE4GAJ4f/zpptFSfXG0Xe4v1MhDWjk6/zrI1n8g?=
 =?us-ascii?Q?xPt14yoLBu2MCqrCKj6JgEO45Te1afMkrYdqEFU+OonRxUWgKbbfPyOsZwTS?=
 =?us-ascii?Q?qhk0VeZQVV6k2eJcO6fi/Pq5lHZFaEuO4r0wx9hTzpgq8KrNNVQslcKJ2rU0?=
 =?us-ascii?Q?yRCMv9cZelE2F1Jhn2Fy7dSoh4lt1Ggp8SEsKp8goq+kAE0TpxULG+B+zoSc?=
 =?us-ascii?Q?8cS8h4kpAF6KK4hyKf9grmLteLTJgT9Akm5/MhtUdUyPXCUqBGpo0AQg34+k?=
 =?us-ascii?Q?aDxjgWpkJrhTEfxeMuQdGTusy9AU+SUxa4GLyEUxoQXM9vpoJ+yVOSuHnv3e?=
 =?us-ascii?Q?9FbAAGNgiHT2MjzZuu/+ZFWpV+LFt0e9YhwaSYEwxcuPxcqXBkz1cFuUdXxm?=
 =?us-ascii?Q?RiAzFxc3URiSBhDZqgbRWvONMu0HsEUueQHAwfkAuhe1aU4O7xnC0iPn2HvN?=
 =?us-ascii?Q?DgKvmqsQWQIdm2aH7nVzsus0rhAgXqe93RAUrt+Dx3c5Rd5f7Q1cIE/c4f7F?=
 =?us-ascii?Q?xYr+PXdpKpHJornXK2bL7BcNJuKoWanryRgiGHf+qcTEf4lIyt35OMac10a1?=
 =?us-ascii?Q?+WIKggizOyKfQdbzILc1ZM5/jDfcQPLYCRtLJZVxdU94YQxmFsdv8yQjgICK?=
 =?us-ascii?Q?z/L2gEa8/zmdkdMWsZzlhZAIe/2NJQbyHqricsUY1eAXcXLeRMKEIYVJANbn?=
 =?us-ascii?Q?iI2Uosv0+5kajXTj91fbDw5alwQ59YS36e0LWT2WekGvMJgtnTySc2ZDACHh?=
 =?us-ascii?Q?F1vkq/LIJldxQBgYgzAe1j61v9xNrOAw9tMFILsTZrekFahYf5LGfY92UE+2?=
 =?us-ascii?Q?7cmD0DM3ELtE4jSaA5/Lbk7NZsXoKrqX/V1aLRp1LHp48l2rgy9UyDKve+fP?=
 =?us-ascii?Q?TOh+RP9o6DeWUwUmdKhDTS6XfFuuuFBHIZjpCIczq3dVmCMQE8QWfl7raY3i?=
 =?us-ascii?Q?+g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hLkUvCxMhg7QBVTnAuuTvJ0ZZqQjyij6OMkewQodfEfNaSffs4/XzXTajDQynNUiaSUFA3++hBziA2Ty+CLS0KY24LE+Ct2zJjkG6TIbBpMLjKg5v4UV98IaEtbinB1Bsyjx/IBuAB4yGC5cxkfZLHOrUOOrEPgqrCsuJFfpKkMn38r41OyvzJ1ZpiCU/RSfupvnVU2UssAKUoDGHSYnI4SBDj5DIkmXva4MjAAjnPm7G8EyZihqbi37Uyn71CTFW9/f2Jozl6c9kdPcR9pYAiDgGOcFPTr7OUk9O4HwcnQXE6mpWo1Aa2wUquuZBy4QcTV3hbfRze2m28r+aMnwx/IGcQDWJLPyCVN1UAXBeXnY+a9L0npoHt+2N83pVLM57SFsu3F1mX0uCcPKoyGwFg0PItRx40iMB8sQwPJ0q4d2gyOlUndbduApU4s1l9K8z2Zsn50qrgxpQmLDn4E1yW/i4F3OO4TMou1Q8PCZokEQ8jRokQmJaMnuKz2zf6OJKGJWGsoat+GVoecD/etactBH8ALZYcAYKFBEYlK4iiGuZoebUqm1CM76sP6lckAunN25LHj1uJr/TBXdLzIGAzs5R6lfR2l7eA0gU3p5TKO9GqFfeoPwypAcFpXChVKpDN0Vg+t441f5q71bDyRcupTqmQkoUt3c8T1A3tjJivahTFKlpVfrYvswScOT7oXm41bUq10wh1YzD/UVCehLwl+SVxQan9b0RZGTwonyln0Ubri0OfgvkCB04GM+QJ0tsmrgkXTM43WTsDCe/BZaVDn3+Mp030mIIVui0hEM7jKy2F385liZmFOuaDt/ODSJjYLhavoti/WOBpJpe7P/8Xkt0NuiDIp96wbpgkhbe2gOd5sa9sxpDwQVXewab76h
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4288093-48c9-4ca4-1484-08dbfa6688e8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2975.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:30:49.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYsXol7VO2MjBqUqFuFveQxTdIQnD7QOCLuLimSvRFpmS4M/AUJRM0fYJagtY/UX40sC597f+jzDFzb6X1s7MRyn5RwOximjh3r4maDA6kQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110135
X-Proofpoint-GUID: tKQm_xSJj1ZQMTlD4cO7OKc-J1JbNssV
X-Proofpoint-ORIG-GUID: tKQm_xSJj1ZQMTlD4cO7OKc-J1JbNssV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 07:59:17AM +0900, Masami Hiramatsu wrote:
> On Fri,  8 Dec 2023 00:07:48 -0500
> Kris Van Hees <kris.van.hees@oracle.com> wrote:
> 
> > The CONFIG_BUILTIN_RANGES option controls whether offset range data is
> > generated for kernel modules that are built into the kernel image.
> > 
> > Signed-off-by: Kris Van Hees <kris.van.hees@oracle.com>
> > Reviewed-by: Nick Alcock <nick.alcock@oracle.com>
> > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >  kernel/module/Kconfig | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
> > index 33a2e991f608..0798439b11ac 100644
> > --- a/kernel/module/Kconfig
> > +++ b/kernel/module/Kconfig
> > @@ -389,4 +389,21 @@ config MODULES_TREE_LOOKUP
> >  	def_bool y
> >  	depends on PERF_EVENTS || TRACING || CFI_CLANG
> >  
> > +config BUILTIN_RANGES
> 
> BUILTIN_MODULE_RANGES ?

Ah yes, thank you.  Will fix in v2.

> BTW, even if CONFIG_MODULES=n, we can embed the kernel module code.
> So should this visible if the CONFIG_MODULES=n ?

That is a very good point.  And in that case, the ranges information should
still be produced when this option is set.  I will move the option to a more
appropriate location, not depending on CONFIG_MODULES.

> Thank you,

Thank you for your feedback!

> > +	bool "Generate address range information for builtin modules"
> > +	depends on VMLINUX_MAP
> > +	help
> > +	  When modules are built into the kernel, there will be no module name
> > +	  associated with its symbols in /proc/kallsyms.  Tracers may want to
> > +	  identify symbols by module name and symbol name regardless of whether
> > +	  the module is configured as loadable or not.
> > +
> > +	  This option generates modules.builtin.ranges in the build tree with
> > +	  offset ranges (per ELF section) for the module(s) they belong to.
> > +	  It also records an anchor symbol to determine the load address of the
> > +	  section.
> > +
> > +	  It is fully compatible with CONFIG_RANDOMIZE_BASE and similar late-
> > +	  address-modification options.
> > +
> >  endif # MODULES
> > -- 
> > 2.42.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA837BE508
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376806AbjJIPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377805AbjJIPhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:37:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F24C102;
        Mon,  9 Oct 2023 08:36:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399EYDob018226;
        Mon, 9 Oct 2023 15:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=2qudVfDdJPmBIHfJetgqh6dUPi/8Z3N2VH23jnl2YPk=;
 b=CXsjxOsi1YAbUGlNVUfR8P11mLLKeRIG8Dxh/VOd5g/0irz0y5+epTWFTFS9aq34NfGq
 twwtqX3V/cwulyVgYCSK156BpqUupFYI0rhMTsC+x4S3x2sPO3BbFufrvuG7gLIoHZ6y
 Gle9BI9Y8yV7Yiv0mKIA11CNwN60jcfCt+JWJ3TyEI76Ba0Yf+TJATNgYsvvA6V6H+np
 IP6x2KVz91CeuT63iFVTjcBblZJgCWy3XhIUUsAfrTtDbzyarDrB3Y3HJVCSXYDksNEM
 MbfEtdc7TBX8Wr38zYFdGVtqNb6x/BWPZ89ZWPDHAvr8cqpH5fR/OPZBVAUbPgo16Ngf Yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu31d5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:36:43 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 399E2rDn004786;
        Mon, 9 Oct 2023 15:36:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws51k0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Oct 2023 15:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGshLwem0xYHd4NSi0i4JwpPbBTdUMtzwZKGLlj+0/dhPVGbhx5JN7po7iWhrNnEQv2lGBl+PpPmce1TYLMmqm+XCzu/Cf6LAVPu0470peXoKjWWmm0w+eSPHeFtyM6+oIVmg+MEYASKTKfaoLkMq3woFW7FdhjULaCAHN5ATxY1wsN7NDrOd4QjG2IiIEGY7RPr/gZvnXhsBuZjXMzdhnLl/C7odzXZG19VEjttsbr5aqmdmXsAXb2oCUd0zwR0/XM+y85uPW6lmzOWURSurxZnSiY7bxw2eMfjvi99g0al0/UTSwLbHw4qV0hHy7am7Snqmm4V4MGXIZ184ASXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qudVfDdJPmBIHfJetgqh6dUPi/8Z3N2VH23jnl2YPk=;
 b=c93WIc+YGoo6ZdJZK3hjylyUt0IkELx1csD3NFW9nc1YgMCoagzEmloW0LoG+WZHlZAu4+AUBMf8hV6QJtzZku4WYXNnvefgcTal+0shEspeddZ9YuJC0+i/WAObYVgS0iRt3kxrUEwlJQDeCSIBSy5M9+SndbOhja+EiWtkwKycd1JiMDAcdvYgwcnRDSZJ3S3i/OYlbjj5xmSoeAeGj55eE54WYttD/D+n/MXi2vdaerkA4OEUNHVSIQLb2fiaM/SnT5df/jnfKNIs8LwFnnifDnXI19kG/x9huUPc/Oj0XyAEb8b+6TtMRWr72Ec81qaa9b7iDTXBJpwVTsCC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qudVfDdJPmBIHfJetgqh6dUPi/8Z3N2VH23jnl2YPk=;
 b=AxUXrItVHERWcg9b7b4vd3l8HMwupCfT/XAMa/97KTBEYXQlDUuzuDHpySPWL2XHlUbCRK7+wHbc83aeNORn1Fvue1WX9ou0DkwAgtWtjv8mnWUmf5+eUhQBKi63NUoFjp5/ItTs5bLGspGVjCdWLbI9z2hxfWgstlNxKG2i3OA=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN2PR10MB4221.namprd10.prod.outlook.com (2603:10b6:208:1d7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Mon, 9 Oct
 2023 15:36:40 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::afa5:d894:d483:c5d2]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::afa5:d894:d483:c5d2%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:36:40 +0000
Date:   Mon, 9 Oct 2023 11:36:35 -0400
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 4.14.324
Message-ID: <ZSQeA8fhUT++iZvz@ostr-mac>
References: <2023083037-conceded-candle-b9e8@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023083037-conceded-candle-b9e8@gregkh>
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|MN2PR10MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: f2620b37-7f74-4ddb-6117-08dbc8dd884c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kLgpmavVMvdUm+/2BejZ2VReBUY1LDk4gOKD8jYb3iYLD2+l1DJoT+MF9u7wcCZ0e+wwoBMw0XT3BKzxhBx2fmc9+nNK+FzKSNHNI3fGaqaOUoD64ryHMOJwnfBnl1hPCGXl8Za8SMG2cSqplY58HjuFjGvEG5u00y5XijSDzHiEkTP/Co0YGaA+kO6VzIuxHV9/RgaG90cRjpCF7Lako2YwiPHWMnBlJnm5G4liVzyna95nniepZhtSiAxBaH34Tr7o9GqTZhPVO1LyitwqDZZm+soJiqqPyRNdak+KnwCrw/cNPox/nt1wPb9Ij1iAtV8mIqAinsdVuC3wkmqxnmJ70jBzPlKhlw0b3l7z9z/ONJks3UYzV5MvfsXn7rdorwHP24rutAT59VGSzVOmul5Bz7UZ6+hCIekSrrxVQzNc6gnRqjv/y7ULdQKZU4Ky7Avj+2XE9dDGHHarnE9IJ3xv/sFLr5HlmpPq1h4LrhAld+WoNSLM02bWx0NFCmvizgzoCpcZ9z7Pqhy6wNkSm1rQkDDdJ3Q0bfccjHiHLV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(38100700002)(33716001)(6512007)(2906002)(9686003)(966005)(478600001)(6486002)(41300700001)(7116003)(5660300002)(6666004)(8936002)(8676002)(44832011)(6506007)(4326008)(83380400001)(66556008)(66946007)(66476007)(316002)(6916009)(26005)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R1uPeMGuLhWBqSom7fEldNx98LL176xarUHQTDDoiYSw/TgMts+3uNvzkjz8?=
 =?us-ascii?Q?+wAbKoRIJeVXqqVHfCAUcqQ6Zu8ocB0n2Gn3mHGqwU6irgnGLhXvRpUQYzqa?=
 =?us-ascii?Q?wtiwV/oSnmTzUowM3a4mNtSnHZZGAqHLiZ/7TVQBUe76VrGoAR5heujTUEVR?=
 =?us-ascii?Q?fsR/BAl7Wh6JVdcvgajg5QFcZwDaWZLEaE1zRHvGorYnLacn7IKs9WhP9fwD?=
 =?us-ascii?Q?O2BNzIMpJHAovYThb21kfay4lajX3W9KQMhBm6ymqUV6regm8PaQBBq92v06?=
 =?us-ascii?Q?ELftw8GUfsTYb7QHMHH3CFffj78hdHAR4kotX+60RObnNbzfYsT5EfCalS3f?=
 =?us-ascii?Q?/aqMPL9GUWSvp1VuXVSGQR+2rVF8oTplz5c7JIMhdS5jArIgqqVHBze7z0VT?=
 =?us-ascii?Q?XedmFBneTiwJcTzBMNAZ4L1tYcp4FMUQq3M/D73z6r4//DFDdUne0c6qPzx+?=
 =?us-ascii?Q?wMDOaRJuJ00a8O8gZBDfzjIZkyFNrvkwHPzNeQi4T7rFS7L2M4DNuBiNh+ul?=
 =?us-ascii?Q?2OI6MY1lykwOh01fg8pmSOs8d7vCUN3R/aMg/IfwXmN8GDrCQ+fDj4l+ZFbL?=
 =?us-ascii?Q?XMg/HVTZePDtNvFySGNO5qRmmoO/Diqtu9HkHXV8P3Tw/0m9Sq0kT3Ybc/M3?=
 =?us-ascii?Q?n/uH5f+H8gLaSXjA6F9Li4gsA0qdgWwHBsXHUQYcdAKESNohDUcHsJIow9GG?=
 =?us-ascii?Q?sYTGfWLKhTm8W+bviFHVemXbwViitcBi70lBphD9fpUUX4wfKQPk2dgJqAh8?=
 =?us-ascii?Q?F/nTElG2OacJsAszopNYMM3z3j03M50pGpwxsOVVeXZvN4EUTWCa6M0jgisg?=
 =?us-ascii?Q?o+ZWGmnsslbAR1NsAlW2N4sP6o2wYDQ38B5NQ696CxoeEpjI7k/KfQ8CXqvi?=
 =?us-ascii?Q?jvBohHb2MdJ4uqy6NImrrzP6tcyHqSWCJrRzoVQUcSq4sQdVIHZymGyb5+Vp?=
 =?us-ascii?Q?vG0PkERXSUAyD1LjmzJfj96bzF6J2VyM8+ZNornVt8oTroVWUFx0QEUyxdBK?=
 =?us-ascii?Q?599dMlTejpsz0DcW7oUpGVmkukNlTzmQkm9TKlLd7R/4dq9yReiklDQyjMOB?=
 =?us-ascii?Q?w2/psEEUeuCYobgXKlt+mlfthf6GC1N6yvrLR3jAX7x4xlYMFSdlN6dLrzow?=
 =?us-ascii?Q?mpjoI1gXeE+wtB8pqpzqvKdMMwo/Un2yKcLEWChCRENjk828eSDnB5s0oIzb?=
 =?us-ascii?Q?gQ09wK5l9noO/QWr2TXbf+lN+h1eas9/UAtn7EwGmQe8V9HKIo1IkPk9oja/?=
 =?us-ascii?Q?lhxecyv48s/+XT8f+ghiCDmQqNZWIFx7v8eVbLzyN8Iq884EniWoW8AY8IB5?=
 =?us-ascii?Q?b1GybRHNRKf7AHLqfMA0Gr5YnVGOAGFhSDFYymWIzLjzPvxRvQHYyY/t0QrL?=
 =?us-ascii?Q?MGGFiyEgETsTZmwt7f4jm3+8A7ku5qCwMdjKURbtyTAtp6JMlwDGUNrM5yip?=
 =?us-ascii?Q?rcofXyxuFaDVvjrttZhscaD0XfAVaRLBxVppdPYNehVvY2IDqFVmqoThelCZ?=
 =?us-ascii?Q?eLdbiyCjLQIJXYFaBr72DlMX0QNvkSMt6U8SIO0aYubVt42kTMQfRFvZHRw+?=
 =?us-ascii?Q?EDb5Nf46g4rHIPaatiGbhVcLUttT9/K3goixUf3t0NSwqLRRF3ElCA/rRyf8?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: utKq4oNkqLShZ3lZEp6+DYzrIuNmLVrjZ673nJtA8yr4JAMSVAPJhvPlmbVQSPzpiIwuUGJXRKmCrMh145acbV4PYgmIou4Po7hSiIHgAk7X+EFB6mlfQfg52CJGk0cP2zJLyg25N2ibcRyPlmYKVqndwm4O5QRzI9De2dL372jMhwJ3Dd14LMGr6DW3sNGDagdGwByeuHHPFSxjl+RE9r2ZzILP0hiS9KMVQsIPgdnOI/8FlqOF4jlGmE+usv/0X3RpYrUUX6/bh85W+vqK2t7lLMfgYFSC+WTIxfeqSDeKBqepNcwgGkDYA+z1RNs57hyoUwkM5yY4iIG7EV/KDoEw4RbPlLDPeVtqykREduiLYH7oZHliMQLwKwWc+2X9RQLNOVb9FWRowRfPGZ2KZ2V6OcxGa78TeZEOJrZZ3QrGytoXet6g2cZefI5R98HeX9C1EfOsoC30RSMiJ9DE9XdfoYtODeeafqyo3pZ1tAZMe4QVdRoNWg4mg1jBq5byWwLfskquk13uhLJQTlQ5KYsj5UAW3fU70fY4C2ykvyXqqZmgq5O3jT/QISyJilyHTxNZVq4HdLqSWp+8S6Qy+eQsqpB1bInCYS2Jk2a1kaCKkXyY2oEd/r+YDIC6pggjFERxlKERsso3D8RdMCZFiOvQlBus/ridJqjL/OmTVKGwncgnFRV/q0rErLevk5HSY6OAPAB5LemgZ+4jGc6uMpxRyk/yqMFRTJuljNrVplElxgqbe85sHLSSNR5Ym1kHuBhn2rxN0bFmCZ07gzKsu0uYGfR/v4I5gZCT/sOWgkaP1W8IlWH6byejbmfqUg5j4y/qjv2auwHhWQq65N072q7iWpd7gITlsebSZ/RUrPImG9XhL9MPPyS1PopuaFbZtYpP2/xjsmfeaKDbj2Mu8Yb63UfMpMgE4tjUd7zUctM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2620b37-7f74-4ddb-6117-08dbc8dd884c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:36:40.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayDC9tEBquba93xef9N58QGKq5stfbObmoDoGxXQMI8LzTvQRo4rMxiQazX1BQOoFj6up2tBF78XJsPwCzhddoSNuxvq20gMe9EAmGE04cA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4221
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_14,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090129
X-Proofpoint-GUID: 4tMH8PFBP0d1kIavmmutH0fa-GepvhuT
X-Proofpoint-ORIG-GUID: 4tMH8PFBP0d1kIavmmutH0fa-GepvhuT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 05:02:37PM +0200, Greg Kroah-Hartman wrote:
> I'm announcing the release of the 4.14.324 kernel.
> 
> All users of the 4.14 kernel series must upgrade.
> 
> The updated 4.14.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
> and can be browsed at the normal kernel.org git web browser:
> 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
...
> 
> Ido Schimmel (1):
>       rtnetlink: Reject negative ifindexes in RTM_NEWLINK


The above commit (69197b2 rtnetlink: Reject negative ifindexes in RTM_NEWLINK)
appears to has been applied icorrectly, causing some regressions (like attaching
a VF to a running guest). The change needs to be made in rtnl_newlink(), not
rtnl_setlink().

I didn't check all other branches but at least 5.4 looks OK.

I believe 69197b2 needs to be reverted and instead this applied:

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a76f3024..f4b98f7 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2547,9 +2547,12 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
                ifname[0] = '\0';
 
        ifm = nlmsg_data(nlh);
-       if (ifm->ifi_index > 0)
+       if (ifm->ifi_index > 0) {
                dev = __dev_get_by_index(net, ifm->ifi_index);
-       else {
+       } else if (ifm->ifi_index < 0) {
+               NL_SET_ERR_MSG(extack, "ifindex can't be negative");
+               return -EINVAL;
+       } else {
                if (ifname[0])
                        dev = __dev_get_by_name(net, ifname);
                else



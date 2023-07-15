Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37503754613
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 03:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjGOB2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 21:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGOB2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 21:28:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DE3A8C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 18:28:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36F00Dut027067;
        Sat, 15 Jul 2023 01:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tMeG2J/x0Hv7EUw3B7ERD1cL+46lof4xujLNo8jHpII=;
 b=J5xnquOCnZF2OYu6DYEcLvmcHLwSO5IjX9PpTjtldqNiHkNT1nRBiB7JjLtw5vJpidos
 ONocJ5BsArHrvXpRd0VP6qqfVhr9x1S0nkp3oGnW9b0W4cFrOShU8UyajgXIfPR99ytY
 X+pCEIMMOWi9UfPJ32eEN9Nt0kFQL+YnEzwZYIrvRCFKUK2RTssZN5DAPaUaegBpT1VG
 TEYad2KLrwTTQ3USW0Cvn+PATT+FgnWlWKK9rI5IrYdzQ4zRBOB2vl4F6jD5NmTpffM5
 01j/kJ15uDgA4UIEkxyXCXzK6AnRYvKXNDWToTnGOJL//uF6uMWBEUWlw2v0t4YZXpZ1 iQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtq9takd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 01:28:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EMKZk0013806;
        Sat, 15 Jul 2023 01:28:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvsfm38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Jul 2023 01:28:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZRDZ3RVC5q1TpKIKJGz7NXhnuK4mPmAunPQeXcOcH1Kd9fW8254kaaiIyD/jPGhjyP2Iz+/wil0+NVqUMMPWmH6jy6iUk1kD+Zq9d2/bn6A7DnYNvSGvC05sRmUXXhV7+gOal9A44MLYcFTnEQIhLXRmNFydLSZ683dJT9T0o0QQdUny6eqsi6n9pVfTW7LrvR3dZx8KiKgJ14MX2tc/bK2eX78zwN5t1pzzs0zL/YHWDm4mqoHcbsxf8Zws650FjqlQFiq1RQbl952NeOSnvvXj6/VbwKXV6r+jKuYrqxv8ne9u24ooSL6+8wPTY216oAbE7+zEH2N6euWsieOj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMeG2J/x0Hv7EUw3B7ERD1cL+46lof4xujLNo8jHpII=;
 b=IwckjJ8VI3kgUGspy4COye0616LbouUXPwG8izwG0bZ2SVOYO2M9xA5PgifeDFxlAmZF5AyZwoDKRPDybZ6dXfmU7cvkv5B/4I8wivkwbXMuYvYUVMXizX3V1BS1gWEqvQ/HGT2jP6oVWO7fR/fKEqgHH651E4WPlfT+cD5HZUYOnTizzZTiaZGfKbhUCqCPUovrFCc2AI6mtjWjq15ODxBJQiP0i4yiEvLuNhmXKDhZ7dYRr6DctcUqZ8S/w3uBKsAS1SqGReIwC0I6+e6lD4aJYdETH+JiB5106OVP0QzGh6URKTKIVu9JDzh3k9LfYFMQ/jdJ5/Q/hzxqB3cmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMeG2J/x0Hv7EUw3B7ERD1cL+46lof4xujLNo8jHpII=;
 b=Kk44yjZlAm4JuoQ/G32vvSA8byC72RnCR7vqoPAKGkgzEJytHrk/lgpNk9BcHsPtR1BhK3bPgi4l44m3GY+0UN2UPluVNemdTcE+Dv87QqK0Cp4975lirqRBT5eJFQiaizIHMhZxex/+4B4dHVDL03XscVAue+9kcJqR8ozjDQc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.33; Sat, 15 Jul
 2023 01:28:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 01:28:27 +0000
Date:   Fri, 14 Jul 2023 21:28:24 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] More strict maple tree lockdep
Message-ID: <20230715012824.ihy6aagy3x7p4g43@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230714195551.894800-1-Liam.Howlett@oracle.com>
 <CAHk-=wioXHeGOmMtLEAtx3enQ3TvtWudeAtK2bwoD0QyBN-GRw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wioXHeGOmMtLEAtx3enQ3TvtWudeAtK2bwoD0QyBN-GRw@mail.gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA2PR10MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a168b0-8661-46a4-b90e-08db84d2ca05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SDRHO2vSONT63JBBIZWiN/XfXpiMnC5ZakaMX5k1powpYyUO70oBv/5BH9mGVoGrJza7pe9/ICAth/9oTzx/E8AO9wdQc7RCEsVtFlhCUWA+1D3aNGL+pdhiyTB21IsS5yWTdvOfp6vj4cNnZQ48+trek+wwfZm94M36gKae06ZLb6pPrWxtpF/0jNA/O6v3pIwCF15+FkQRSZqdP0S7E6OlB8E7fW/IhPdD6I20odIQo5E8JbZ+S7RRxaM4/Tg8bJRGHc3/K0rmaDC31crLyyubAdq8rZzUbI2LaJbYhKM22dTMVhnHrol9GQV1m7RewRZzsi7dUqALOXea6es5q1JK3N5UYLt0ZANzOZ4ISp73M4aSa9MlcyEd6sffzvzcZxuI9rUrte2FzGdBx60pPp5BAQsH0xKcVE3DuCvUT4al3reH9d2VmAa9xtfxx3x+0RXqpxedCJ5vUcWHpAon11GW8Q/M6iN1l7jvTQQxdAJTKgqPRnKC3TLsfeclWuxDkoO7vXpwAylRSUVsgJ9tXItJDsV/TACrJl8k3+c3ZHixfpGvkkdftCzcLgDvNLa7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(41300700001)(66556008)(66476007)(4326008)(6916009)(66946007)(478600001)(4744005)(5660300002)(316002)(2906002)(8676002)(8936002)(6666004)(6486002)(6512007)(26005)(1076003)(9686003)(6506007)(86362001)(186003)(83380400001)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rk9k6D2cBqaNwkGzq62TSCmO8iYt+4dh2NHn8BuB7esfJoAx9G47I3uDBjzx?=
 =?us-ascii?Q?QqAtKoK+rxw2PfPxfYkTA+PcjUvhajwJIq2ya48LMoLddWe/4dbkc/IXv7Fb?=
 =?us-ascii?Q?sjqpe4R8WBCme6z7QQNH+cmRclKWAV5ymJwm2ERfbcIZl348/JHd6b2JYb2J?=
 =?us-ascii?Q?acaMM24MtBupshrw/2Rt+3z9LFh/lDZvBY4PitjZcbPL7jH8px1AMOo1YmhU?=
 =?us-ascii?Q?ag5UYDBYKSufZh5/heK8MdeYFVVJat7VPnDx1f2DTOTyc+GN8SKTiikHc72c?=
 =?us-ascii?Q?Hx2e/xAf0XbyG92DrBOhGwCHiKBFKjxa0c7R8lx8/sduyjnweFlqKpAOOwRY?=
 =?us-ascii?Q?ftZmDGy20ngRAlhcZ1r+Y3/6q+XWY7jPTS6XBuP6T7yVpuMs+gfENW11i/qB?=
 =?us-ascii?Q?yajmkOukRp4l5gLIjUvNMFwly5WCra2QbqOo6GarhnTLZwbH71ccIXhpX9Ee?=
 =?us-ascii?Q?whm9dLoYSCMhl38VgBBzpIZRMroExwIkl04BoH/ocRPkEaVbYH59EPleCwb9?=
 =?us-ascii?Q?kgj9KKW5CU+SozD17g7F+RQxMWeo893H/svWUUBhmC2FTNfpusmRoGgUfqgK?=
 =?us-ascii?Q?rVak6mFzrXm/uT3HiMpHZYzOwNzjtoFygPOy30TSS6iRZTbfP/UTj0q+MP56?=
 =?us-ascii?Q?FPQmZPGcS7ZSl9kiPtHp8xbu4UfCRFKdmYOA/jDM/eZ2TEvRsmjT0MFDL0n4?=
 =?us-ascii?Q?j3asFaRfZH1heNwD0I+eR7pZSJFAa/u4yW+m6kACga49e+FgsAuh3PULJa+q?=
 =?us-ascii?Q?PPutC5oGVQkCOthnGiYk5vtyyi4COjvXeKV0NOm1TkBcEEdVcCsl6IqDygZH?=
 =?us-ascii?Q?lQRvimZzc14FyJ4KB1dWcSYIR+cRBf+speVUKVl/+L14cM1piOqlawj2e1lu?=
 =?us-ascii?Q?qTyXWFxdjmeHvQuuqeZnHTNhGpwCanjuohnTmqu9jgiWDDGpzUxlTctiSYcF?=
 =?us-ascii?Q?/+XRQW4qxGvYC/wAUbzXk2Sg/6XK2Fyhlk6NhWGwo94wGsIK0OxqsUQwWUUv?=
 =?us-ascii?Q?RvCmXlS2diUj0fYfrNdRvlr8yd+MqnmV+MDLZENWLMv9tOjKvwDcmb8huG9I?=
 =?us-ascii?Q?ArntvLEafQcgDaHUK9AfTYQyP1E50ulXl+aB6sNDaqvJJimRpT6L1sfMtC6x?=
 =?us-ascii?Q?wZitXahpwGe71Y1UBa4PiGO9YwcUmkhxU/gtBK0rAA0jq1zqLCfBkCqgDXcv?=
 =?us-ascii?Q?g8qotiVO7lJz4z7jExEyStGBtcVZ3zFp5J5W+ReA8GMGfZbsSGxIVECNktOA?=
 =?us-ascii?Q?WFLuYxRLlQ+kwSsBu+UR19NDjmu2dX2VG4GBZKabS83JITm0jiSf2szBIyY1?=
 =?us-ascii?Q?khEa5rbu3vilWWpyXBTIgUU6V5my3trLZ9Nzj1C0eu5Bei5jNAcQI+WYBnAg?=
 =?us-ascii?Q?y58UdV4/dndPpNIz7g8J7/Xz7vYCeHnXoZGFZ3uWkyZiy47v0ikf0WXh1xbF?=
 =?us-ascii?Q?MC3ID4qh2R/9EwOB+230dPjW+ptfyfpzNtmjWbycjugvpfDu+pl4qrXXT0+I?=
 =?us-ascii?Q?s7fjp6xRbnD88JzpGnfzyeBb2KVmxx8jxI3KhNPzQgINSwEHevIEAw+XhhJG?=
 =?us-ascii?Q?T5yBQeaxB+eOtcIztmw3NWt+meP4jah5HfpGGQJcLohFyFfXEOfEaw6pIwhq?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CxzNmWM2tK0edCmdQhDeVIWnmoWZHbthVD8njw3QVw4W0r1c5c9QWPEGfy0zz664W8IDEH6VFxQst8xpCtZGuhkwBwprR5sGYr5xxnjPYGehZAqmJsNa6tsgRfm9Daw1nCr4IKWU9vaaLximsnWkjALH9NrzlVA2KlJ5GwAx1j28pfG+y1blP7YHFlCiviaIxVpWFDGI6aGt7s/zsnDugq5+yNkbYrIMV5VNWBvxZjI6scAfEPvX4o+1FsQY4BSBJTaHBDObRIAr6Pszbp2k/fRkED0sdnzq6AfjUvtMMd0wPzALfBgtibpyey6V+x+qJtnmgCc/9uZ6iEV/Y3Z2aQqrdytRPh0ntg2tbrFKczVOa+zk2A5ufexOS+tsZlobc/WRxiOrFZqpIUxlMBStWLLXM2ECjTyIXccW4TsV2Ez3NGjRG5vf/HmTswz7Dzkm5ypLKVR9KWPRsvemQW3uM7K+KVQun3CxR14fDs3hzFhibHlGk2XiK0ONcVlQqT86uJ6+E9SqD19mRqbuitIi+kFiRlqpiLpWXyV9AwZYRGd7+fZDX3i6XZmxZzdwftgaQN9qP0BFHRXOKQuz3FWwXlvOv7Ve1DhN1FMwAfgEmuxUZCxyP63r/mUqYVX5B21m7ELqs+RHHE1ywTdMsxfxXe9ri189vtD2t50gntjjjFR6Tn8VA65g5LeLxmh9V6tqymQxT0k0gkSXCEPaBOAuE1Ytl/bbTiH3SsefnARdaKdAXxjXQvJQf49UjdTcImvEzow1XHfq6do58al+TCW6pF8vPQctyUGuw7YbfSPD52NuQ1P5uDxiKNc8Sqf9HGjgHak29VB03t5YR62FObLG//XXMqB17WcXHw17M/HxyXVTUQmyK8HE+tBa3qqqo4shDAKrUlcsvsaFrGmhMum8/g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a168b0-8661-46a4-b90e-08db84d2ca05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 01:28:27.2372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSU7YvGd43D1Iqgvx1qF27hJHf0cVpP8fQwiYlyK3TfRExp9tkUEx+1azkeRRc33KsZErQon0hzqd3EaYOHAUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_12,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=696 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307150012
X-Proofpoint-ORIG-GUID: jcT8RM1tFmpWDZ-MX-nk-h3ZGOECOoPA
X-Proofpoint-GUID: jcT8RM1tFmpWDZ-MX-nk-h3ZGOECOoPA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [230714 16:16]:
> On Fri, 14 Jul 2023 at 12:56, Liam R. Howlett <Liam.Howlett@oracle.com> wrote:
> >
> > This series of patches adds checks to ensure the lock is held in write
> > mode during the write path of the maple tree instead of checking if it's
> > held at all.
> 
> Ack, LGTM. I assume that there were no lockdep errors found by all this..
> 

No lockdeps errors.  My config has the additional CONFIG_PROVE_RCU=y
this time, which I missed during the previous locking changes.

Thanks,
Liam

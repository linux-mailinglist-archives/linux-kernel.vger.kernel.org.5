Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7BE7A76C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjITJDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjITJCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:02:53 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE60E6B;
        Wed, 20 Sep 2023 02:01:20 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38K8bgQR030527;
        Wed, 20 Sep 2023 09:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Mohp1it2fuStPgjZFWndSxQM4fJB7eSFvn/pk/8hp3g=;
 b=R62j+KGMg8MLPWL5rWd49EBtjA0Bso+JGYrzPvvwXROLpBbptsp83iXbrZXNpPXF8tLu
 se5PP/rlSNlwsxtvZNWFEAupeLGAZ5c0AWBUTygs/NU7aU/SsmFD3MJ+CKHZx+YVmLWP
 RvRou0VIs/F/8AMv1rBmJgU+l+R4kTeSZvL9kEWf7BJPoT2zLRnyyg3lATinrnc98+is
 ZrDnbzxiLlNywzjkP1BYk7E9lJh5TGPQguSUzrankfIne/aVNM5ntT6rAuHjCoj+IrzD
 oMiX20YR7DXX7SymfoMS8XbhtgIPkiKVRTOx9nOT3xEW7rVC8H6r8rbE3IKIIUAcJyIm Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7uyktreq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 09:01:05 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38K8oL2j020320;
        Wed, 20 Sep 2023 09:01:05 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t7uyktrdn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 09:01:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38K80FOJ016478;
        Wed, 20 Sep 2023 09:01:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t5sd23pnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 09:01:03 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38K910iM42860902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 09:01:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CADD2004B;
        Wed, 20 Sep 2023 09:01:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EF3C20043;
        Wed, 20 Sep 2023 09:00:59 +0000 (GMT)
Received: from [9.171.25.3] (unknown [9.171.25.3])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 20 Sep 2023 09:00:59 +0000 (GMT)
Message-ID: <09ef007793b27e2ba5cc75a33c99cf8ead62c7f3.camel@linux.ibm.com>
Subject: Re: [PATCH net-next 06/18] net/smc: extend GID to 128bits for
 virtual ISM device
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Wen Gu <guwen@linux.alibaba.com>,
        kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 20 Sep 2023 11:00:59 +0200
In-Reply-To: <50feb145-c658-b9a1-7261-b67bb82767dc@linux.alibaba.com>
References: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
         <202309201408.95QRxHEl-lkp@intel.com>
         <50feb145-c658-b9a1-7261-b67bb82767dc@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -xJqZMDZELOQZeTMMC-6VI-qX47e5pK8
X-Proofpoint-ORIG-GUID: 5i4CY911fQhg1eaHcOE9NGFW-SNB-Uy8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_03,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-09-20 at 16:11 +0800, Wen Gu wrote:
>=20
> On 2023/9/20 15:02, kernel test robot wrote:
> > Hi Wen,
> >=20
> > kernel test robot noticed the following build errors:
> >=20
> > [auto build test ERROR on net-next/main]
> >=20
> > url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-d=
ecouple-ism_dev-from-SMC-D-device-dump/20230920-010019
> > base:   net-next/main
> > patch link:    https://lore.kernel.org/r/1695134522-126655-7-git-send-e=
mail-guwen%40linux.alibaba.com
> > patch subject: [PATCH net-next 06/18] net/smc: extend GID to 128bits fo=
r virtual ISM device
> > config: s390-defconfig (https://download.01.org/0day-ci/archive/2023092=
0/202309201408.95QRxHEl-lkp@intel.com/config)
> > compiler: s390-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20230920/202309201408.95QRxHEl-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202309201408.95QRxHEl-l=
kp@intel.com/
> >=20
> > All errors (new ones prefixed by >>):
> >=20
> >     net/smc/smc_ism.c: In function 'smc_ism_signal_shutdown':
> > > > net/smc/smc_ism.c:539:57: error: incompatible type for argument 2 o=
f 'lgr-><U72f8>.<U7260>.smcd->ops->signal_event'
> >       539 |         rc =3D lgr->smcd->ops->signal_event(lgr->smcd, lgr-=
>peer_gid,
> >           |                                                      ~~~^~~=
~~~~~~~
> >           |                                                         |
> >           |                                                         str=
uct smcd_gid
> >     net/smc/smc_ism.c:539:57: note: expected 'u64' {aka 'long long unsi=
gned int'} but argument is of type 'struct smcd_gid'
> >=20
> >=20
> > vim +539 net/smc/smc_ism.c
> >=20
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  526
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  527  int smc_ism_signal_shutdo=
wn(struct smc_link_group *lgr)
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  528  {
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  529  	int rc =3D 0;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  530  #if IS_ENABLED(CONFIG_ISM)
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  531  	union smcd_sw_event_info=
 ev_info;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  532
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  533  	if (lgr->peer_shutdown)
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  534  		return 0;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  535
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  536  	memcpy(ev_info.uid, lgr-=
>id, SMC_LGR_ID_SIZE);
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  537  	ev_info.vlan_id =3D lgr-=
>vlan_id;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  538  	ev_info.code =3D ISM_EVE=
NT_REQUEST;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23 @539  	rc =3D lgr->smcd->ops->s=
ignal_event(lgr->smcd, lgr->peer_gid,
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  540  					  ISM_EVENT_REQUEST_=
IR,
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  541  					  ISM_EVENT_CODE_SHU=
TDOWN,
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  542  					  ev_info.info);
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  543  #endif
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  544  	return rc;
> > 820f21009f1bc7a Stefan Raspl 2023-01-23  545  }
> > 201091ebb2a161a Ursula Braun 2020-09-26  546
> >=20
>=20
> I do not have a local compilation environment for s390 (IBM Z) architectu=
re. But I think
> it can be fixed by the following patch.

With these kernel test robot mails the bot provides
instructions for reproducing with a cross toolchain from the 0day
project. See the line starting with "reproduce (this is a W=3D1 build):"
i.e. in this particular case it links the URL:
https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@=
intel.com/reproduce


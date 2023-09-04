Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29E379162F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352789AbjIDLXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 07:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIDLXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 07:23:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45AEC;
        Mon,  4 Sep 2023 04:23:50 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384B76C7032618;
        Mon, 4 Sep 2023 11:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=18hcT6yXJn2tFaqyvC/NxnGagB5rLNOvWBdaP7t7Fdc=;
 b=tWS5Xyp6hQnyXkU1B455CswOUMY5EHzKNxMv4JgOvbFP1tlA9wS9neu4NoauOnggSF2Q
 xlMaStXInkr1BcrQV6z3790qmQ+PIoI4jMM6EmQKenzee89h4d9OVpTle2Y/U6gUmt2P
 hcAigASh6RPcBFFA/xHyDZaRTdTVzAx+G7aEojBrRDFG2Weyg+ZtMxRbSz8ErW/6uQcb
 egFnlTx7doeui7tv7H0nGQqgPaITNWpAR0wptLcHO/LIua3I3N4VoiEBpjoBvmfDvCta
 fYnUSKEsUIJif8h+ylGGnRAjbBvlzTZW3+6LsUR2raOnuMtOxZyoPFKt5UwEtZ/dXoiC 0g== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sw83113vx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 11:23:40 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3849EoVt001598;
        Mon, 4 Sep 2023 11:23:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsafky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Sep 2023 11:23:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 384BNbRW61211096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Sep 2023 11:23:37 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8224B20043;
        Mon,  4 Sep 2023 11:23:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1545520040;
        Mon,  4 Sep 2023 11:23:37 +0000 (GMT)
Received: from [9.179.17.91] (unknown [9.179.17.91])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  4 Sep 2023 11:23:36 +0000 (GMT)
Message-ID: <65d620b2644e2d60b041815fa4bb544a818ae55a.camel@linux.ibm.com>
Subject: Re: [PATCH] comedi: Fix driver module dependencies since HAS_IOPORT
 changes
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Ian Abbott <abbotti@mev.co.uk>, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        stable@vger.kernel.org
Date:   Mon, 04 Sep 2023 13:23:36 +0200
In-Reply-To: <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
References: <20230901192615.89591-1-abbotti@mev.co.uk>
         <33c2292b-08cb-44c7-9438-07d4060976ab@app.fastmail.com>
         <f0e88ae3-d38e-40d1-900c-395ddc9c8231@mev.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _mnbov4EJe3ozMh6ASmD9jofbOaqFz07
X-Proofpoint-ORIG-GUID: _mnbov4EJe3ozMh6ASmD9jofbOaqFz07
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 mlxlogscore=509 clxscore=1011 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309040099
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-04 at 11:10 +0100, Ian Abbott wrote:
> On 03/09/2023 16:49, Arnd Bergmann wrote:
> > On Fri, Sep 1, 2023, at 15:26, Ian Abbott wrote:
> > > Commit b5c75b68b7de ("comedi: add HAS_IOPORT dependencies") changed t=
he
> > > "select" directives to "depend on" directives for several config
> > > stanzas, but the options they depended on could not be selected,
> > > breaking previously selected options.
> >=20
---8<---
> > > @@ -735,8 +738,8 @@ config COMEDI_ADL_PCI9111
> > >=20
> > >   config COMEDI_ADL_PCI9118
> > >   	tristate "ADLink PCI-9118DG, PCI-9118HG, PCI-9118HR support"
> > > +	depends on HAS_IOPORT
> > >   	depends on HAS_DMA
> > > -	depends on COMEDI_8254
> > >   	help
> > >   	  Enable support for ADlink PCI-9118DG, PCI-9118HG, PCI-9118HR car=
ds
> >=20
> > I don't see why you'd remove the 'depends on COMEDI_8254' here
> > rather than turning it back into 'select' as it was originally.
>=20
> Oops!  That's an error on my part.  Thanks for catching it!
>=20
> >=20
> > It might be easier to revert the original patch, and then follow
> > up with a fixed version.
>=20
> Will any random config builds break in 6.5 stable if the original patch=
=20
> is reverted, or is the 'HAS_IOPORT' stuff still in preparation for=20
> future use?
>=20

The patch that finally compile-time disables I/O port accesses as well
as a few others are still not merged. I was away for a few weeks and
also still have a few todos. I also and found a few things needed for
new changes. So no a revert will not break compiles or anything like
that.

Thanks,
Niklas


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E21E7B2F63
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjI2JjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 05:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbjI2JjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 05:39:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FE41A8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 02:39:04 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rxlbk10lcz685Td;
        Fri, 29 Sep 2023 17:36:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 29 Sep
 2023 10:39:01 +0100
Date:   Fri, 29 Sep 2023 10:38:59 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     Peter Newman <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jon Masters <jonmasters@google.com>,
        "Eranian, Stephane" <eranian@google.com>
Subject: Re: resctrl2 - status
Message-ID: <20230929103859.00002d3f@Huawei.com>
In-Reply-To: <SJ1PR11MB6083C7959787B9816D951E0FFCC1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <fb9499b9-c445-01e8-8427-6b05256abdb5@intel.com>
        <ZOkU+d4AsLGSAG+y@agluck-desk3>
        <b48fe955-c1b4-4aeb-1ab0-bf26e56e1f0e@intel.com>
        <ZOlRNTq3lE7VNHjU@agluck-desk3>
        <9742f177-a0ce-c5d3-5d92-90dda32f5d07@intel.com>
        <ZPjDHN0nvHz9kWFn@agluck-desk3>
        <18f3a209-8dbf-4837-6bcb-a71a1ee1abb3@amd.com>
        <SJ1PR11MB6083849D1AEF44806C4D669AFCEDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
        <09e2894e-eb2b-12a0-c4a2-5000b27bbded@amd.com>
        <ZPuqsupe+BevodqO@agluck-desk3>
        <ZQSY5P8R5Q+OuvXB@x1>
        <20230918114420.000058c3@Huawei.com>
        <CALPaoCiDrbfAYW1sHgozVUew2wdvuGgkATbO62Dj0BEiQf5cZg@mail.gmail.com>
        <SJ1PR11MB6083C7959787B9816D951E0FFCC1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2023 14:47:13 +0000
"Luck, Tony" <tony.luck@intel.com> wrote:

> > I got us a BoF session to talk about resctrl and porting it to new
> > architectures:  
> 
> Thanks for doing this.
Great!

> 
> > https://lpc.events/event/17/contributions/1567/
> >
> > To anyone planning to attend, while the schedule is still easy to
> > adjust, please let me know if the proposed time (Nov 15, 4:30-5:15pm)
> > doesn't work.  
> 
> Do you know if the BoF sessions are going to be remote accessible?
> Personal conflicts mean I can't attend in person.

They were last year (it worked surprisingly well). If there are any problems
we can set up a jabra in the room.

I'm keen to attend this. That time currently works for me though I got
the impression things are still very fluid on schedule (I sent a list
of uconfs to avoid for the PCI device attestation BoF that is just before
this in the posted schedule.)

So if there are obvious clashes to avoid, (I can't immediately spot any
general ones) then pass those on.

Jonathan

> 
> -Tony


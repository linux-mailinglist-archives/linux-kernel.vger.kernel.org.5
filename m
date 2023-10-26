Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0067D87E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjJZR57 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 13:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJZR55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:57:57 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2DAC;
        Thu, 26 Oct 2023 10:57:55 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id 79A04160B8F;
        Thu, 26 Oct 2023 17:57:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id 6BAAF6000B;
        Thu, 26 Oct 2023 17:57:39 +0000 (UTC)
Message-ID: <eb9c31b2121a164a88bdd8cac663f6880cd52a93.camel@perches.com>
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Justin Stitt <justinstitt@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Date:   Thu, 26 Oct 2023 10:57:38 -0700
In-Reply-To: <202310261049.92A3FB31@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
         <202310260845.B2AEF3166@keescook>
         <39ca00132597c0cc4aac4ea11ab4b571f3981bcb.camel@perches.com>
         <202310261049.92A3FB31@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: hudth4n5i9tsh6noik99p4dqoecq4yae
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 6BAAF6000B
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/FhF5iyLmTVijiQINcZ0DKfw8kt4QZXAA=
X-HE-Tag: 1698343059-8063
X-HE-Meta: U2FsdGVkX18EvEmoxNdb8hk6+O6ituHbXxaJFt94yuI4o75cydbMBKO9R15wtEF6VkcdjuFdT9yaMhXRm3vYaUDQE0fY4PwycxT9WeFqvMNRLqEIHiYE+D7Xg4oAc80cClcOXyOn1zfquNjuxwquDIEP8tJmMNk6z3BfC3ZuK2ggJziXypVPsEUK9Keu4FQ3ncfCo+W3BOl6Fmr3KUjH1uOPVXyJ4NSisvMVQpPwtWe6RV1E6cbgFDGHwkHsXtaww+tTwpwABR38XLVHFAAk31CQ+RyAx3SylbbeObJ26LbpA+oEHLjf/YBdaYbPa+iv
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 10:49 -0700, Kees Cook wrote:
> On Thu, Oct 26, 2023 at 09:33:17AM -0700, Joe Perches wrote:
> > On Thu, 2023-10-26 at 08:47 -0700, Kees Cook wrote:
> > > On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> > > > @replace_2_args@
> > > > identifier BUF;
> > > > expression VAR;
> > > > @@
> > > > 
> > > > -       ethtool_sprintf
> > > > +       ethtool_puts
> > > >         (&BUF, VAR)
> > > 
> > > I think cocci will do a better job at line folding if we adjust this
> > > rule like I had to adjust the next rule: completely remove and re-add
> > > the arguments:
> > > 
> > > -       ethtool_sprintf(&BUF, VAR)
> > > +       ethtool_puts(&BUF, VAR)
> > > 
> > > Then I think the handful of weird line wraps in the treewide patch will
> > > go away.
> > > 
> > 
> > Perhaps this, but i believe spatch needs
> > 	 --max-width=80
> > to fill all 80 columns
> 
> Ah, yeah. Default is 78. Current coding style max is 100... I'll adjust
> my local wrappers.

Coding style max is still 80 with exceptions allowed to 100
not a generic use of 100.



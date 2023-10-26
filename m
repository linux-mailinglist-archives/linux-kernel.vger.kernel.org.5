Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FD27D8546
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 16:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345326AbjJZOxO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Oct 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjJZOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 10:53:12 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28F51AA;
        Thu, 26 Oct 2023 07:53:09 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 4391440158;
        Thu, 26 Oct 2023 14:53:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 983F820027;
        Thu, 26 Oct 2023 14:52:52 +0000 (UTC)
Message-ID: <a196427632d824ee0f39ef8da3188a0405bb2893.camel@perches.com>
Subject: Re: [PATCH 2/3] treewide: Convert some ethtool_sprintf() to
 ethtool_puts()
From:   Joe Perches <joe@perches.com>
To:     Louis Peens <louis.peens@corigine.com>,
        Justin Stitt <justinstitt@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
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
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Date:   Thu, 26 Oct 2023 07:52:51 -0700
In-Reply-To: <ZTp8VgdC5yVkrFeA@LouisNoVo>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
         <20231025-ethtool_puts_impl-v1-2-6a53a93d3b72@google.com>
         <ZTp8VgdC5yVkrFeA@LouisNoVo>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 983F820027
X-Stat-Signature: f6rwzr5tdz6au99az5suny8a7mijkrbc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Qdw/iYiftXcMZ8GOytXsi0vlklpywPbo=
X-HE-Tag: 1698331972-527693
X-HE-Meta: U2FsdGVkX1/1MIUVFb/Hgk2tNLjvKG+o6wsUTD1CdlUY3VOZyRBIATzUA9gR2f5zcRVjVw1mMT9BLUbdoKmRYvl1eUmaGLar8G99TydWQIQ3OljsmfFN4SqHRuQkRuOopphBbmW35d4zz2g2nnw9Z3NFEmutjwzMW4q3jNinJ5fRf8RwuSFJQhLcp7vLNPyMu7XW0l2SM83ttIlF4a/KXvtx2SAxqeTuejRFixLDJ5Ib2HqkMtyoPCgGfZtBapq75g7b2MlQXv3+j9NxTxVBCgZLU2L54BktcVcEEOFF0qnQfdR2RXb4BzFr6UmcB8s5r7V2B2RppmkIa9qglYe7WHfAC0kwp27f+MdiWaFxlAWenFcL6+2MYQnkwudNJ/7K
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-10-26 at 16:48 +0200, Louis Peens wrote:
> On Wed, Oct 25, 2023 at 11:40:33PM +0000, Justin Stitt wrote:
> > This patch converts some basic cases of ethtool_sprintf() to
> > ethtool_puts().

[30k of quoted content]

> Thanks Justin. From my perspective the series looks good, though I've
> not spent very long on it. For the nfp parts:
> 
> Acked-by: Louis Peens <louis.peens@corigine.com

Do please remember to trim your replies.

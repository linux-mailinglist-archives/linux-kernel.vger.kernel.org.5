Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47C87D78F7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjJYXxR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 19:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:53:16 -0400
X-Greylist: delayed 82 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Oct 2023 16:53:14 PDT
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D497693;
        Wed, 25 Oct 2023 16:53:14 -0700 (PDT)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id 73084140753;
        Wed, 25 Oct 2023 23:53:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id EB8562000F;
        Wed, 25 Oct 2023 23:52:58 +0000 (UTC)
Message-ID: <c7e45f79e04cf28b69300cc12cf47267fb216955.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: add ethtool_sprintf rules
From:   Joe Perches <joe@perches.com>
To:     Justin Stitt <justinstitt@google.com>,
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
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org
Date:   Wed, 25 Oct 2023 16:52:58 -0700
In-Reply-To: <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
         <20231025-ethtool_puts_impl-v1-3-6a53a93d3b72@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Stat-Signature: ewynon9iqkxk4ba7ojpnwtcnyur8eded
X-Rspamd-Server: rspamout07
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: EB8562000F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19HM4U+AZp5TxLK9aKEhza6ficBJMSjAYo=
X-HE-Tag: 1698277978-811897
X-HE-Meta: U2FsdGVkX1+p9+z8yCq32YY8S2DSMu0GtmU5Y2BLTOHLbVa47GMVGnlUfueykHLbFBJzUqiIuNUoLTjPNpuPmPmdObkyQyyYuvVzxDUXUYBXVjgtSZL2VLZt0M+ihq91yI+KJMnhw13lDleMsbRbUz2084V9BtLz3jRVgcLorLaY772BDVcKhBSdvFtDf2GPoSWp62x76n++3gowAjGE0QzGeGP1a3j/o4yx5i3/j7G9kDn6arjCylGwRoNsTERruOxHd2GpijuQvv1XVYKqXSIlXskZ2U42iC6tNJZVsKH071QZzpcUdpEeBh6ZYV0q
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-25 at 23:40 +0000, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
> 
> The two cases are:
> 
> 1) Use ethtool_sprintf() with just two arguments:
> >       ethtool_sprintf(&data, driver[i].name);

OK.

> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> >       ethtool_sprintf(&data, "%s", driver[i].name);

I'm rather doubt this is really desired or appropriate.



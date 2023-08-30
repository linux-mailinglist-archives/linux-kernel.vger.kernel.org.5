Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3196E78DDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbjH3SvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242391AbjH3IYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD34B113
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 557AE62840
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEA8C433C9;
        Wed, 30 Aug 2023 08:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693383886;
        bh=Dw9c1DXIAY68a849K5SUG04VmXYyYAHrBl2h6ksyWj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EgcU5iYqRWDPKRDTvyVru5KDSlEMnfMA8mWLaUmd2wIwP6+zw8w2QohrkfX1vXqoJ
         /yhlUchRWhs0wTyJVPhBhvQGvKHArvTZB5wAMqrLMIo1vHGrqd8o20yJOOPvR1aAWH
         7WerVmEH/eTW51KaLQ1ux5PmgxQHcilj057bIvf55ni/vE6ICzvY5RZhH8IFbKJlEX
         vHIpV+Upt0c5eVepzLMP/gOgUd7ZOeeDGwy0XNcpUAxGMMs1FtWJYyAKzfTy1Kzf8k
         Y4AneGPbl4ou0hxMgXmfa7C20ndTWPSK/feYw42w+VNMHQalV0dKvuupJNl5920Uv8
         Rou9OMXKWQqPQ==
Date:   Wed, 30 Aug 2023 10:24:42 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: kernel/user_namespace.c:239: warning: Function parameter or
 member 'map_up' not described in 'idmap_key'
Message-ID: <20230830-koiteich-ehrerbietung-8191852e752b@brauner>
References: <202308172003.O1QB7TgB-lkp@intel.com>
 <9a05d92f-60c5-6ede-2105-829f09c737b7@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a05d92f-60c5-6ede-2105-829f09c737b7@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:13:06PM -0700, Randy Dunlap wrote:
> Hi Christian,
> 
> On 8/17/23 05:56, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> > commit: e227db4d4f125efb1cae2f1337da85bc10b3185e userns: fix a struct's kernel-doc notation
> > date:   7 months ago
> > config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/config)
> > compiler: hppa64-linux-gcc (GCC) 12.3.0
> > reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308172003.O1QB7TgB-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> kernel/user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
> >>> kernel/user_namespace.c:239: warning: Function parameter or member 'id' not described in 'idmap_key'
> >>> kernel/user_namespace.c:239: warning: Function parameter or member 'count' not described in 'idmap_key'
> >    kernel/user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
> >    kernel/user_namespace.c:246: warning: Function parameter or member 'e' not described in 'cmp_map_id'
> >    kernel/user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
> >    kernel/user_namespace.c:277: warning: Function parameter or member 'map' not described in 'map_id_range_down_max'
> >    kernel/user_namespace.c:277: warning: Function parameter or member 'id' not described in 'map_id_range_down_max'
> >    kernel/user_namespace.c:277: warning: Function parameter or member 'count' not described in 'map_id_range_down_max'
> >    kernel/user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
> >    kernel/user_namespace.c:295: warning: Function parameter or member 'map' not described in 'map_id_range_down_base'
> >    kernel/user_namespace.c:295: warning: Function parameter or member 'id' not described in 'map_id_range_down_base'
> >    kernel/user_namespace.c:295: warning: Function parameter or member 'count' not described in 'map_id_range_down_base'
> >    kernel/user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
> >    kernel/user_namespace.c:344: warning: Function parameter or member 'map' not described in 'map_id_up_base'
> >    kernel/user_namespace.c:344: warning: Function parameter or member 'id' not described in 'map_id_up_base'
> >    kernel/user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
> >    kernel/user_namespace.c:364: warning: Function parameter or member 'map' not described in 'map_id_up_max'
> >    kernel/user_namespace.c:364: warning: Function parameter or member 'id' not described in 'map_id_up_max'
> >    kernel/user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
> >    kernel/user_namespace.c:776: warning: Function parameter or member 'extent' not described in 'insert_extent'
> >    kernel/user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'
> > 
> 
> According to 'git blame', all of these come from additions that you made.
> 
> What do you think about a patch that converts all of these into non-kernel-doc comments?
> I.e., change "/**" to "/*" for the functions and struct?

Yeah, sure.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A0D78BDB9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjH2FNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjH2FNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:13:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728E198
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 22:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=v7yy8KuNyAVC/aJA6ag651RbI8R+xf9nSt8GLFJg/IA=; b=1HB3hUuCNWuPyEv/taD47yOU/N
        OMMBbTzRgLijiV/at3P8KdHd8BdUIyAMklbIEMXBRVhQQSw7bfiNaVQ2AmvTG02FYVnNjHJsx20hY
        P18Q3npchkXjDgTxF65LdAIMzRG2QnceKXm9ZG5DlKbgDHrlHJCKSuf7ei89ss8cooCJeLw1cSrCZ
        2ujIMF6zBMMU2/+gljEv0LkVrQNM1vnEBRL9PHoP01oFG/kYhKCzH0m1f62qdGi9jrmUPPJw2Qn8B
        Mz6nYUIXUvAk6kTZluBmqAo3u9g6muCUgPgrwT+H4/W9CZ+F/8Mfsl4O9EjZuQRIGyjnm+PwYc5Hy
        GQSDQuKw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qar2L-00AnWf-2V;
        Tue, 29 Aug 2023 05:13:09 +0000
Message-ID: <9a05d92f-60c5-6ede-2105-829f09c737b7@infradead.org>
Date:   Mon, 28 Aug 2023 22:13:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: kernel/user_namespace.c:239: warning: Function parameter or
 member 'map_up' not described in 'idmap_key'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202308172003.O1QB7TgB-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202308172003.O1QB7TgB-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On 8/17/23 05:56, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> commit: e227db4d4f125efb1cae2f1337da85bc10b3185e userns: fix a struct's kernel-doc notation
> date:   7 months ago
> config: parisc64-defconfig (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/config)
> compiler: hppa64-linux-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308172003.O1QB7TgB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308172003.O1QB7TgB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/user_namespace.c:239: warning: Function parameter or member 'map_up' not described in 'idmap_key'
>>> kernel/user_namespace.c:239: warning: Function parameter or member 'id' not described in 'idmap_key'
>>> kernel/user_namespace.c:239: warning: Function parameter or member 'count' not described in 'idmap_key'
>    kernel/user_namespace.c:246: warning: Function parameter or member 'k' not described in 'cmp_map_id'
>    kernel/user_namespace.c:246: warning: Function parameter or member 'e' not described in 'cmp_map_id'
>    kernel/user_namespace.c:277: warning: Function parameter or member 'extents' not described in 'map_id_range_down_max'
>    kernel/user_namespace.c:277: warning: Function parameter or member 'map' not described in 'map_id_range_down_max'
>    kernel/user_namespace.c:277: warning: Function parameter or member 'id' not described in 'map_id_range_down_max'
>    kernel/user_namespace.c:277: warning: Function parameter or member 'count' not described in 'map_id_range_down_max'
>    kernel/user_namespace.c:295: warning: Function parameter or member 'extents' not described in 'map_id_range_down_base'
>    kernel/user_namespace.c:295: warning: Function parameter or member 'map' not described in 'map_id_range_down_base'
>    kernel/user_namespace.c:295: warning: Function parameter or member 'id' not described in 'map_id_range_down_base'
>    kernel/user_namespace.c:295: warning: Function parameter or member 'count' not described in 'map_id_range_down_base'
>    kernel/user_namespace.c:344: warning: Function parameter or member 'extents' not described in 'map_id_up_base'
>    kernel/user_namespace.c:344: warning: Function parameter or member 'map' not described in 'map_id_up_base'
>    kernel/user_namespace.c:344: warning: Function parameter or member 'id' not described in 'map_id_up_base'
>    kernel/user_namespace.c:364: warning: Function parameter or member 'extents' not described in 'map_id_up_max'
>    kernel/user_namespace.c:364: warning: Function parameter or member 'map' not described in 'map_id_up_max'
>    kernel/user_namespace.c:364: warning: Function parameter or member 'id' not described in 'map_id_up_max'
>    kernel/user_namespace.c:776: warning: Function parameter or member 'map' not described in 'insert_extent'
>    kernel/user_namespace.c:776: warning: Function parameter or member 'extent' not described in 'insert_extent'
>    kernel/user_namespace.c:844: warning: Function parameter or member 'map' not described in 'sort_idmaps'
> 

According to 'git blame', all of these come from additions that you made.

What do you think about a patch that converts all of these into non-kernel-doc comments?
I.e., change "/**" to "/*" for the functions and struct?

> 
> vim +239 kernel/user_namespace.c
> 
> 5c1469de7545a3 Eric W. Biederman 2010-06-13  230  
> 6397fac4915ab3 Christian Brauner 2017-10-25  231  /**
> e227db4d4f125e Randy Dunlap      2023-01-07  232   * struct idmap_key - holds the information necessary to find an idmapping in a
> 6397fac4915ab3 Christian Brauner 2017-10-25  233   * sorted idmap array. It is passed to cmp_map_id() as first argument.
> 6397fac4915ab3 Christian Brauner 2017-10-25  234   */
> 6397fac4915ab3 Christian Brauner 2017-10-25  235  struct idmap_key {
> 6397fac4915ab3 Christian Brauner 2017-10-25  236  	bool map_up; /* true  -> id from kid; false -> kid from id */
> 6397fac4915ab3 Christian Brauner 2017-10-25  237  	u32 id; /* id to find */
> 6397fac4915ab3 Christian Brauner 2017-10-25  238  	u32 count; /* == 0 unless used with map_id_range_down() */
> 6397fac4915ab3 Christian Brauner 2017-10-25 @239  };
> 6397fac4915ab3 Christian Brauner 2017-10-25  240  
> 
> :::::: The code at line 239 was first introduced by commit
> :::::: 6397fac4915ab3002dc15aae751455da1a852f25 userns: bump idmap limits to 340
> 
> :::::: TO: Christian Brauner <christian.brauner@ubuntu.com>
> :::::: CC: Eric W. Biederman <ebiederm@xmission.com>
> 

thanks.
-- 
~Randy

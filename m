Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915D783DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbjHVKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjHVKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:30:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA5CF4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:30:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 592DF6516E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EECC433C9;
        Tue, 22 Aug 2023 10:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692700208;
        bh=70xFTByQ1/Lb6Cdvza+q6+K4Gi0UbjmSlxNHah3ifG8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=O/Z1mWgLXIczqKdwdBYUegIgBWSBp4x39unZjWlPUxcVM0VGzyAka91Iwz3IFqFTz
         EQWVY4e1FEiOt8vlauA92JsDLQij+IX+JiNMSFtvsAcWfQ4oYGMR0lzXpaZcDBmaaj
         w7XiVBMaW+YGPT2WqrbQgyUsTB8Urjngzjt+3MO7Vnfy6fKF1VdzFAICz1u46sS0Q2
         JhTui8+bWJ7EBtYmYni4OiU/2UF59RXqc5ZMzgdEHcuO7zlGNxyJLtX6RszQ2R8B4k
         Cm9cgRd2k71zy2LrHYmUNEGsDY4rUHMj2smMY4LaCUew519OuwmhRkJj3qKmyQH+aH
         IC8moyhwVxPQQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 22 Aug 2023 13:30:05 +0300
Message-Id: <CUZ057BXGCE1.2E8MOHQ8NVINE@suppilovahvero>
Cc:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>,
        "Serge Ayoun" <serge.ayoun@intel.com>
Subject: Re: arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter
 or member 'low' not described in 'sgx_calc_section_metric'
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "kernel test robot" <lkp@intel.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>
X-Mailer: aerc 0.14.0
References: <202308221542.11UpkVfp-lkp@intel.com>
In-Reply-To: <202308221542.11UpkVfp-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Aug 22, 2023 at 10:27 AM EEST, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   f7757129e3dea336c407551c98f50057c22bb266
> commit: e7e0545299d8cb0fd6fe3ba50401b7f5c3937362 x86/sgx: Initialize meta=
data for Enclave Page Cache (EPC) sections
> date:   2 years, 9 months ago
> config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/2023=
0822/202308221542.11UpkVfp-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221542=
.11UpkVfp-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308221542.11UpkVfp-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or mem=
ber 'low' not described in 'sgx_calc_section_metric'
> >> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or mem=
ber 'high' not described in 'sgx_calc_section_metric'
>
>
> vim +124 arch/x86/kernel/cpu/sgx/main.c
>
>    117=09
>    118	/**
>    119	 * A section metric is concatenated in a way that @low bits 12-31 =
define the
>    120	 * bits 12-31 of the metric and @high bits 0-19 define the bits 32=
-51 of the
>    121	 * metric.
>    122	 */
>    123	static inline u64 __init sgx_calc_section_metric(u64 low, u64 high=
)
>  > 124	{
>    125		return (low & GENMASK_ULL(31, 12)) +
>    126		       ((high & GENMASK_ULL(19, 0)) << 32);
>    127	}
>    128=09
>
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

https://lkml.org/lkml/2023/8/22/379

BR, Jarkko

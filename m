Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3B980FB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377963AbjLLXKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377895AbjLLXKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:10:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF4AA;
        Tue, 12 Dec 2023 15:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702422608; x=1733958608;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=X6zFIevK/0rDBo9jQjfWf0VXCOMWFHI8YoKvjECYLIs=;
  b=AzEZb2bQ9+Rc566P30asIv0HzWZXpt94gdIebhc+S//zcPlHk8cCraoc
   s9otW8lii8pzSgCkc/rGEfWhNTMRtuF0lrk7ZKqjWeWCyanPOtYq2wBGP
   MOkxd5R7v0BxK456Z9eUxvFMsQT2AHw6G/sEpljGiCfASByQwUdUw6BtL
   Sxjl2SyxcCiGfEanAyHgvixJ0jc+6+7CLrZC4FZLSWf3gNZxGgXSfjNBZ
   v5fYEpm4ENsZj35Fuc5wdwQOH6A0fDvviXry1MNCbopDNrnZVvzGQWFOq
   gemP5USI8FQUjisflW+Et2Xmzu/FilpGxUG0GPOCcrwV9hIDdppWUfc9A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="461359273"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="461359273"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:10:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="773734424"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="773734424"
Received: from rfield-mobl1.amr.corp.intel.com (HELO [10.209.75.26]) ([10.209.75.26])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 15:10:07 -0800
Message-ID: <b3c71b866bb249107ed2920e31a7ec185b2f0b15.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation, mm/unaccepted: document accept_memory
 kernel parameter
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Vlastimil Babka <vbabka@suse.cz>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Tue, 12 Dec 2023 15:10:07 -0800
In-Reply-To: <20231212-accept_memory_param-v1-1-a9012402b887@suse.cz>
References: <20231212-accept_memory_param-v1-1-a9012402b887@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-12-12 at 18:21 +0100, Vlastimil Babka wrote:
> The accept_memory kernel parameter was added in commit dcdfdd40fa82
> ("mm: Add support for unaccepted memory") but not listed in the
> kernel-parameters doc. Add it there.
>=20
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 65731b060e3f..3a4ebb46073c 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1,3 +1,13 @@
> +	accept_memory=3D  [MM]
> +			Format: { eager | lazy }
> +			default: lazy
> +			By default, unaccepted memory is accepted lazily to
> +			avoid prolonged boot at the cost of some runtime

Suggest rephrasing this line. Breaking up long line makes reading easier.

avoid prolonged boot.  The lazy option will add some runtime

Thanks.

Tim
> +			overhead until all memory is eventually accepted. In
> +			most cases the overhead is negligible but for some
> +			workloads or for debugging purposes accept_memory=3Deager
> +			can be used to accept all memory at once during boot.
> +
>  	acpi=3D		[HW,ACPI,X86,ARM64,RISCV64]
>  			Advanced Configuration and Power Interface
>  			Format: { force | on | off | strict | noirq | rsdt |
>=20
> ---
> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> change-id: 20231212-accept_memory_param-4a7adc5e5582
>=20
> Best regards,


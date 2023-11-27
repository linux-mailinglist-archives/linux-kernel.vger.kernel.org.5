Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A397F9DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjK0Kph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbjK0Kpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:45:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD5118A;
        Mon, 27 Nov 2023 02:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701081936; x=1732617936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XsgutPECrC8l5gZt5+iuVfsFhO1Zmfqw++3pChr2uHc=;
  b=qh760psJeXKP2+K+/updKoyvsVNsQqTxVuyc+xozoKNJqV7GCR82tPl1
   0YWvvoUEUsmPT4pMX8msClqbxzbtoq8BnLUE4ibM8jRfp3ezqkCBx+kVo
   iYzgJ8HStCRd85srYfSaZeaya5ojdJBEo7egvdHUbBPoTROf5dA2iLhQb
   DSP68PIsWMSwZ8ZLp0awIfpJFFjTwF9DdAu2qKn13WVC6qx7UKrl/hql3
   G+ShpPzB7iBzljGvtmoo5XCB+kA2RgidWLwy6bBPu/kKT8zJV1VFwidHY
   iL33dv50fTaT4M8JxO+z1JPL9PrT3HBhF3E0XU30mIeKUqc8I/jwGXj/t
   Q==;
X-CSE-ConnectionGUID: rYZD7AvDRIS8Nns1pfsCSg==
X-CSE-MsgGUID: ITAVCmDsQuKHnJuT89msKA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="asc'?scan'208";a="12250830"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 03:45:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 03:45:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 03:45:23 -0700
Date:   Mon, 27 Nov 2023 10:44:54 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Charlie Jenkins <charlie@rivosinc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Message-ID: <20231127-epilogue-frying-4d5ba926617c@wendy>
References: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
 <20231122-fencei-v1-1-bec0811cb212@rivosinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2dabZgh7yH7Wi+77"
Content-Disposition: inline
In-Reply-To: <20231122-fencei-v1-1-bec0811cb212@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2dabZgh7yH7Wi+77
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 22, 2023 at 05:03:20PM -0800, Charlie Jenkins wrote:
> +
> +/**
> + * Enable userspace to emit icache flushing instructions.
> + *
> + * When in per-process context, there may be multiple threads using the same mm.
> + * Therefore, the icache can never be assumed clean when. Multiple threads in
> + * the process may modify instructions in the mm concurrently.
> + *
> + * In per-thread context, it can be assumed that all modifications to
> + * instructions in memory will be performed by this thread. When the thread is
> + * migrated the icache will be flushed.
> + *
> + * @arg arg: Sets the type of context
> + *  - PR_RISCV_CTX_SW_FENCEI: Allow fence.i in userspace. Another fence.i will
> + *			      emitted on thread/process migration.
> + * @arg per_thread: When set to 0, will use the default behavior of setting the
> + *  icache flush context per process. When set to 1, will use a per thread
> + *  context.
> + */

FYI, this is not valid kerneldoc and breaks allmodconfig builds:
 arch/riscv/mm/cacheflush.c:159: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

> +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)


Cheers,
Conor.

--2dabZgh7yH7Wi+77
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWRzJgAKCRB4tDGHoIJi
0oqZAP44BpqU7jjixzWH8EBV8qfD5EEkTbqtGTccnCfX4BmMOgEA+me3rwJrd9e/
7h830aetbBTs0XpjcvFkekSOcjjKfwg=
=GeQD
-----END PGP SIGNATURE-----

--2dabZgh7yH7Wi+77--

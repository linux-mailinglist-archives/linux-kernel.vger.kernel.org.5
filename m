Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B47AB673
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbjIVQtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbjIVQtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:49:11 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E841A4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:49:05 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-493a661d7b6so2608032e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695401344; x=1696006144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfhJ8cCD8LbiVlnmen43E6hAzTOc5umd4YIJIcbToqg=;
        b=Fb7FhX3Gwo2oJYCpCwiHjZ2biehwlzN7T3h2Cn5Cn3ngAzGEkUd0zbtu81byl2EuZ+
         E5m++iFFUEqYV5EaUa5t0jl4hWU4Y+KIgRaFU68obNBzMsxEeb6vLsSeWK6CPwV3cLuj
         NFh1bUJIFHszDheON91hDTRsjmMijAIk7fIUod8M/C15S0Cp8L/3/aC3FfszTZ6/Yrwt
         lRVLVsNCQcOdvs8UNvmFao82J3eJsRXiEEAF98kHdIxnE1n2ijCn+l0DqHdVTCO5UB6+
         3ZuBRCoTP0HmsAqRz6hgOzlLZKK4OhvIZClmOSIQQP/lKjhlpdgBQnhXjaOEdt3zIZHN
         nSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695401344; x=1696006144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfhJ8cCD8LbiVlnmen43E6hAzTOc5umd4YIJIcbToqg=;
        b=lOsI9KVFOOeB6331rJeb9mFK6Du4t1TFKB1flbkft2FO4trYufoOLKkVfrSqkusWtS
         MgivwDjtu5yvhrF6n7E7k3QkuBegkRGtVszOeJdwNXohjf6nKg/zgufR0zJYny0V82cM
         uvJIQZdlN/ahtrgncfS+kHOC7WPQ90IZp1cRx+DsxFcGDZgLwvunEVp5SVrzoVI9FGEZ
         D07xjiBuS7D5C6hOUCE6pYRNBKRkJzO1S4b17OGcNWDW3ZeZozrcEHLtSX/cJdf7dZmr
         yBF87RKwqzhWcMRyP+Cp7SA29JHQZ6i6cN9EmwvujcxLo6Xk8LQt5PN/CPVKei2E53VV
         hqwA==
X-Gm-Message-State: AOJu0YzDjX+uWMQ6wOCUqIaAOlEgbx9YoIZwOID0cPBKroAzQ4RIenvs
        vV/iKJn7nDZmVpbL0kTbPZsT02hV1OYi0xHokk+jRpnTPNiz0zonoXWeSg==
X-Google-Smtp-Source: AGHT+IEeS0SBQ9GuZ6EG0hKT0SODWW/vXeCY+Skp94AbYpC4nC/UJMGEGFnylZa0tcMmEzMSzSbeULC3kwVOy3KmrMk=
X-Received: by 2002:ac5:c913:0:b0:495:c8bb:f0f8 with SMTP id
 t19-20020ac5c913000000b00495c8bbf0f8mr1715785vkl.3.1695401344498; Fri, 22 Sep
 2023 09:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <202309230010.Eio2q6e0-lkp@intel.com>
In-Reply-To: <202309230010.Eio2q6e0-lkp@intel.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 22 Sep 2023 09:48:53 -0700
Message-ID: <CAKH8qBvT2Rb2EHgpNfQa2LtngbH1zyZwyDAFrMPg8_d86eKUTw@mail.gmail.com>
Subject: Re: net/core/xdp.c:725:5: error: no previous declaration for 'bpf_xdp_metadata_rx_timestamp'
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 9:12=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Stanislav,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
> commit: 3d76a4d3d4e591af3e789698affaad88a5a8e8ab bpf: XDP metadata RX kfu=
ncs
> date:   8 months ago
> config: x86_64-sof-customedconfig-avs-defconfig (https://download.01.org/=
0day-ci/archive/20230923/202309230010.Eio2q6e0-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20230923/202309230010.Eio2q6e0-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309230010.Eio2q6e0-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> net/core/xdp.c:725:5: error: no previous declaration for 'bpf_xdp_meta=
data_rx_timestamp' [-Werror=3Dmissing-declarations]
>     int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *time=
stamp)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> net/core/xdp.c:737:5: error: no previous declaration for 'bpf_xdp_meta=
data_rx_hash' [-Werror=3Dmissing-declarations]
>     int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>         ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

I don't think I'm doing anything special for these kfuncs, so, in
theory, the rest of them should also have the same warning.
Should we add another __diag_ignore_all("-Wmissing-declarations", ...)
to kfuncs preamble?
I remember there was a discussion about introducing
BEGIN_KFUNC/END_KFUNC, but I don't think it went anywhere?


> vim +/bpf_xdp_metadata_rx_timestamp +725 net/core/xdp.c
>
>    713
>    714  __diag_push();
>    715  __diag_ignore_all("-Wmissing-prototypes",
>    716                    "Global functions as their definitions will be =
in vmlinux BTF");
>    717
>    718  /**
>    719   * bpf_xdp_metadata_rx_timestamp - Read XDP frame RX timestamp.
>    720   * @ctx: XDP context pointer.
>    721   * @timestamp: Return value pointer.
>    722   *
>    723   * Returns 0 on success or ``-errno`` on error.
>    724   */
>  > 725  int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *=
timestamp)
>    726  {
>    727          return -EOPNOTSUPP;
>    728  }
>    729
>    730  /**
>    731   * bpf_xdp_metadata_rx_hash - Read XDP frame RX hash.
>    732   * @ctx: XDP context pointer.
>    733   * @hash: Return value pointer.
>    734   *
>    735   * Returns 0 on success or ``-errno`` on error.
>    736   */
>  > 737  int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, u32 *hash)
>    738  {
>    739          return -EOPNOTSUPP;
>    740  }
>    741
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

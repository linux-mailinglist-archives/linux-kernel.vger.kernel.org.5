Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795E8124E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjLNCFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNCF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:05:29 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C4F4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:05:36 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db53919e062so8568495276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519535; x=1703124335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEZvumk7MgtmWweazFTl3ViX2nGxgFVZEAs/ufpHI5M=;
        b=neg1a/BIWXM/MAD5vta/dZqWHpqOuN93ROqTn4BGpe7sZ4wN8/8Ef97zUZExi5sZMa
         sbNpaCN8Y9lMCARCHs7kLsvrYRsgCg1KQ31QfiRIFisLk1cODdNLIgD91pHEJswS07LI
         BN3xbzLnqsSkxRzONVykCYISbFDWgEyTc9xRYCmSlDawBwKYTityKpmsJo9PAsADJ36A
         j2OYub/q5FV7tQziph1lnp5mUsPHQBrfwj/RS17ErghJ/lOxzjMMDZ73WBuLU4hhIxRw
         yygMhm4UlW/OjUBbBmYeUqPpooairasFeuQGK+IC6Jq0xY1PMBN5yLIQAL4GR7rh3B5r
         BUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519535; x=1703124335;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEZvumk7MgtmWweazFTl3ViX2nGxgFVZEAs/ufpHI5M=;
        b=Um05Err78eVZ83rPL95zBU6+7Xzd929J09LK6+TELimzRX75J/qpGimlEflQLv6cxs
         SLLf2dL7ztSr4UdUmYlCjgh3/2zP4+XCeszik6/LGvz521cLnzPHR0nLoCJ6lOaa7Om6
         RVsGLXxRGVlIkJTp0pJc+GfDzWtTXASAf0W+WSSJvpUHrGAHSiwx50cY+ru06HsD0ys+
         JunKJhe1g2gxWifNz7ihXNJdGOat/FFwyPaL3UoEuxLi5QkU8ksLE+gEK2gIAcPzawOp
         BSFUsr6bdY8jjZJZ/gVfK4kkCIjtFjDj/84drEOHQwA4Dw0LDtnPRgIizCf89tg3HD2R
         KOEw==
X-Gm-Message-State: AOJu0YzYd4NTt6eLygeZHt92ZSbMggICl/NY2prPYCxQ9KgpKfipFqfo
        5rOlTixCatDEiD11vT+x0DhOaK4NtsgSGiT25pljuWoDTYY39E5LNSUy8EZNRC0W8RwpAR7Ggpw
        QPW+w5leHO5qzw45BnpCitdYYqHmdkntJ4i6AgIlb3SPeoQddLwDBYdfPsEdOOtEhw/Y9u3bFQC
        DhU5JO/HA=
X-Google-Smtp-Source: AGHT+IEeQgDesKe3i+QDS/rezaXpGa7RoKAiDBO9Ys/1XaviI6mis9BGhANKrNA1DQEcY996FnoLnUQecY6J10j8wA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a5b:783:0:b0:db5:4766:e363 with SMTP
 id b3-20020a5b0783000000b00db54766e363mr77867ybq.6.1702519534471; Wed, 13 Dec
 2023 18:05:34 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:05:23 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-1-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 0/4] Abstract page from net stack
From:   Mina Almasry <almasrymina@google.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Mina Almasry <almasrymina@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently these components in the net stack use the struct page
directly:

1. Drivers.
2. Page pool.
3. skb_frag_t.

To add support for new (non struct page) memory types to the net stack, we
must first abstract the current memory type.

Originally the plan was to reuse struct page* for the new memory types,
and to set the LSB on the page* to indicate it's not really a page.
However, for safe compiler type checking we need to introduce a new type.

struct netmem is introduced to abstract the underlying memory type.
Currently it's a no-op abstraction that is always a struct page underneath.
In parallel there is an undergoing effort to add support for devmem to the
net stack:

https://lore.kernel.org/netdev/20231208005250.2910004-1-almasrymina@google.=
com/

Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>

Mina Almasry (4):
  vsock/virtio: use skb_frag_page() helper
  net: introduce abstraction for network memory
  net: add netmem_t to skb_frag_t
  net: page_pool: use netmem_t instead of struct page in API

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 15 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  8 ++-
 drivers/net/ethernet/engleder/tsnep_main.c    | 22 +++---
 drivers/net/ethernet/freescale/fec_main.c     | 33 ++++++---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 14 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 15 ++--
 drivers/net/ethernet/marvell/mvneta.c         | 24 ++++---
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 18 +++--
 .../marvell/octeontx2/nic/otx2_common.c       |  8 ++-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 22 +++---
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  | 27 ++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 28 ++++----
 .../ethernet/microchip/lan966x/lan966x_fdma.c | 16 +++--
 drivers/net/ethernet/microsoft/mana/mana_en.c | 10 +--
 drivers/net/ethernet/socionext/netsec.c       | 25 ++++---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 48 ++++++++-----
 drivers/net/ethernet/ti/cpsw.c                | 11 +--
 drivers/net/ethernet/ti/cpsw_new.c            | 11 +--
 drivers/net/ethernet/ti/cpsw_priv.c           | 12 ++--
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 18 +++--
 drivers/net/veth.c                            |  5 +-
 drivers/net/vmxnet3/vmxnet3_drv.c             |  7 +-
 drivers/net/vmxnet3/vmxnet3_xdp.c             | 20 +++---
 drivers/net/wireless/mediatek/mt76/dma.c      |  4 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  4 +-
 drivers/net/xen-netfront.c                    |  4 +-
 include/linux/skbuff.h                        | 11 ++-
 include/net/netmem.h                          | 35 +++++++++
 include/net/page_pool/helpers.h               | 72 ++++++++++---------
 include/net/page_pool/types.h                 |  9 +--
 net/bpf/test_run.c                            |  2 +-
 net/core/page_pool.c                          | 39 +++++-----
 net/core/skbuff.c                             |  2 +-
 net/core/xdp.c                                |  3 +-
 net/kcm/kcmsock.c                             |  9 ++-
 net/vmw_vsock/virtio_transport.c              |  2 +-
 38 files changed, 381 insertions(+), 239 deletions(-)
 create mode 100644 include/net/netmem.h

--=20
2.43.0.472.g3155946c3a-goog


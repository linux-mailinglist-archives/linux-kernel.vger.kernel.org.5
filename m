Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675D8124E7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235247AbjLNCFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbjLNCFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:05:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2616FE4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:05:38 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-dbcca990ee9so1811155276.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702519537; x=1703124337; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+ronbOySVVJCeCFXE+E452YTaKGaTM58JCsYafTPHk4=;
        b=O2j4yHTFdH4Gpg94umNd+/vXPVzeJMcj0A46SsXoBpcqoVIHwpjY6eXU/AdPlb1yUd
         6779vyYmeDcnhCnDOOagQRJ2hdBCLXYU0Z0uCDcIqyibpqDwupCLm3GY4wkWV6U/yCmx
         kx8lCopO+tYLcm7ub7xqp1ePTyowyQ/kbUWT9D3DjcnwvF8YGCYCS2S9rIvqDOy8f5BC
         oQiuHbbOA1wEQDdN8cYGYdiZVATuGAiUa/5n8Dwd0CgYCUuirhxfd88m6Lx5ULI+hRbN
         GGnLMu5OvnMFoucjTH8IOENKXYUr2RhiyO4IWUvRvn8aIbvk7/0o4MsO3GN4KFLtxxHQ
         AbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702519537; x=1703124337;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ronbOySVVJCeCFXE+E452YTaKGaTM58JCsYafTPHk4=;
        b=nr371bosPMmHkhbZpZneM77za902f6Psv9zAATHF6ZFNLmUUsopqoDxXM+S+NDZv0z
         EH9bxZRC5M0OMH2LFcEbro4MAo4SUydOH0w5CD/NTjVSwXEbJHu3AbKHSvQ87WdLoFuk
         AFHz28ST5fUp9pnZQ8zesa6Yk191X91LErNDcKaP7/m9EX6nGky89QKlwTlI4tbg3xgU
         rw8LiElIbdFyAZ7BghOYjk+hSEhHzp73FxPhA+UnGNmcn9CvgfHWk4NJDzwEfLwEcXA2
         eeaq/Hb+LBQraB6FE8j8snvj+MQYa+4qZziBR7KLNLKOCGVeXo2o2ye17sDVl4ZtGIiW
         X/hg==
X-Gm-Message-State: AOJu0Yxie/yrXO+ThdZwnnICu4wwVg5IaEJUfkqUyRkeZQ/U70C5Lh1m
        aN9NrVBlWp0IcQXPxk8EL5lAQ4VYEympndUMCq23ZAJnUFX9HtfDMghd+mkX6Zj7fZ7G2QTymxt
        7Fd3yAtGNVc435A8deGH6Y4kM0nck6VqSs3JRMpcKjMDuu6n1iP+j2FOqgU2Tz4jPdUiTIt6ho4
        K/Lk3styk=
X-Google-Smtp-Source: AGHT+IGncV41fwbhz/mCy6hSR3EOohDoL5eRhnTHrk4bhzSdLjyeCnLJseqiKf/w0iEIyiWoDGOSz2aVqCYno2zrog==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:d31b:c1a:fb6a:2488])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:545:b0:dbc:e64a:ccd6 with
 SMTP id z5-20020a056902054500b00dbce64accd6mr1821ybs.9.1702519536540; Wed, 13
 Dec 2023 18:05:36 -0800 (PST)
Date:   Wed, 13 Dec 2023 18:05:24 -0800
In-Reply-To: <20231214020530.2267499-1-almasrymina@google.com>
Mime-Version: 1.0
References: <20231214020530.2267499-1-almasrymina@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214020530.2267499-2-almasrymina@google.com>
Subject: [RFC PATCH net-next v1 1/4] vsock/virtio: use skb_frag_page() helper
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor fix for virtio: code wanting to access the page inside
the skb should use skb_frag_page() helper, instead of accessing
bv_page directly. This allows for extensions where the underlying
memory is not a page.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 net/vmw_vsock/virtio_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index af5bab1acee1..bd0b413dfa3f 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -153,7 +153,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 				 * 'virt_to_phys()' later to fill the buffer descriptor.
 				 * We don't touch memory at "virtual" address of this page.
 				 */
-				va = page_to_virt(skb_frag->bv_page);
+				va = page_to_virt(skb_frag_page(skb_frag));
 				sg_init_one(sgs[out_sg],
 					    va + skb_frag->bv_offset,
 					    skb_frag->bv_len);
-- 
2.43.0.472.g3155946c3a-goog


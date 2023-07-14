Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1601A753F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbjGNPzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235238AbjGNPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:55:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E386730FC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6687446eaccso1996406b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689350106; x=1691942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=23iFgtcXrSM/wqHFC50gmHfN2DfdTspVrWVZMTWF67M=;
        b=jVVndNxSJywFc3NlTe7W4yP3yU7NCgigpzMr+FQbbEvXGao5yncV705uEsUHe+SsoH
         99ahIHBc808HZFPmudJtgOEMfoALXOrhBGEH/5iOoJP0M0QQaAurUJwVbwvDh8rCWyFm
         0mOdTbt8hmBwtxDeUh5QRPqHwXPIqgVZNGldoXiTm0eDhVqBfh+70yBcJwuiProAPmNP
         q/bsMSOuP5fGR6gpmHPhHBCAGFMboGnKQPaY5xYLCGUxj9eKBY7inLb+03hQDErrcHpw
         o1qif2uGPWsACD+WU5iH4kmBUQe/D+z7BmCSmmyvl9y8UNGUZZpD2xWPHtSqInNnfuFp
         5rXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689350106; x=1691942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23iFgtcXrSM/wqHFC50gmHfN2DfdTspVrWVZMTWF67M=;
        b=W9ajdsA1pp1pH13zGv9+EtbucVsU/9kf7EiXgWRO/bgKMgORmskaF8cqbB8V0Tv7Gz
         LFTCLHl+Pz4t8VYKvHMaI51alP1kWr3QWPDjGxEV6KVk3n1lWr+Xgls4cFH+GEgHkwfc
         vkFu/Zl/OL0yH9uTIbvEhxPmtfBGGniHZsJSbw/wOItf+QZTeb4qttyJh15szHl8o6jg
         fJYGGY14vcjDRGoxAdkWNOwrjwYgxmHCvr8cNtsiN5NRvnTUxpj8ducP3jupwwTbuVUj
         aGnT6HoqCzHFFxJLcPPb7st75s8zWztBOVnLs0xGOYBGA8+Hyw91bCaPcs4Pr01GPGIW
         OPJg==
X-Gm-Message-State: ABy/qLbGVLc/1jhhAitb9ukpS184qb2lYAlnRl3gAlcyC9hedgYKLRrW
        SpdRE7cAqqJVG1YIsBjjiZNw3Q==
X-Google-Smtp-Source: APBJJlE1OjvT/TWbZXaXcXtxRNjTULARYcXX/dBfz79zC72vXKyKqx8JeuoEXOUCn7f0w2b2Le5zeg==
X-Received: by 2002:a05:6a00:1951:b0:668:731b:517e with SMTP id s17-20020a056a00195100b00668731b517emr5873790pfk.24.1689350106259;
        Fri, 14 Jul 2023 08:55:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a63b709000000b0055be951145csm7037672pgf.36.2023.07.14.08.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:55:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qKL8K-0017jv-8O;
        Fri, 14 Jul 2023 12:55:04 -0300
Date:   Fri, 14 Jul 2023 12:55:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Hari Ramakrishnan <rharix@google.com>,
        David Ahern <dsahern@kernel.org>,
        Samiullah Khawaja <skhawaja@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>,
        brouer@redhat.com, Alexander Duyck <alexander.duyck@gmail.com>,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Eric Dumazet <edumazet@google.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jonathan Lemon <jonathan.lemon@gmail.com>, logang@deltatee.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Memory providers multiplexing (Was: [PATCH net-next v4 4/5]
 page_pool: remove PP_FLAG_PAGE_FRAG flag)
Message-ID: <ZLFv2PIgdeH8gKmh@ziepe.ca>
References: <04187826-8dad-d17b-2469-2837bafd3cd5@kernel.org>
 <20230711093224.1bf30ed5@kernel.org>
 <CAHS8izNHkLF0OowU=p=mSNZss700HKAzv1Oxqu2bvvfX_HxttA@mail.gmail.com>
 <20230711133915.03482fdc@kernel.org>
 <2263ae79-690e-8a4d-fca2-31aacc5c9bc6@kernel.org>
 <CAHS8izP=k8CqUZk7bGUx4ctm4m2kRC2MyEJv+N4+b0cHVkTQmA@mail.gmail.com>
 <ZK6kOBl4EgyYPtaD@ziepe.ca>
 <CAHS8izNuda2DXKTFAov64F7J2_BbMPaqJg1NuMpWpqGA20+S_Q@mail.gmail.com>
 <143a7ca4-e695-db98-9488-84cf8b78cf86@amd.com>
 <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPm6XRS54LdCDZVd0C75tA1zHSu6jLVO8nzTLXCc=H7Nw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 07:55:15AM -0700, Mina Almasry wrote:

> Once the skb frags with struct new_abstraction are in the TCP stack,
> they will need some special handling in code accessing the frags. But
> my RFC already addressed that somewhat because the frags were
> inaccessible in that case. In this case the frags will be both
> inaccessible and will not be struct pages at all (things like
> get_page() will not work), so more special handling will be required,
> maybe.

It seems sort of reasonable, though there will be interesting concerns
about coherence and synchronization with generial purpose DMABUFs that
will need tackling.

Still it is such a lot of churn and weridness in the netdev side, I
think you'd do well to present an actual full application as
justification.

Yes, you showed you can stick unordered TCP data frags into GPU memory
sort of quickly, but have you gone further with this to actually show
it is useful for a real world GPU centric application?

BTW your cover letter said 96% utilization, the usual server
configuation is one NIC per GPU, so you were able to hit 1500Gb/sec of
TCP BW with this?

Jason

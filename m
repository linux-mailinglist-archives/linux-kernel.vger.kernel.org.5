Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78708770595
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjHDQFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHDQF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:05:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED1149D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:05:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31759e6a4a1so1833136f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691165124; x=1691769924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ox8Iga73YVuYG7AbvArZALqGxDCiOsgsOfD0SAAN2aw=;
        b=MYpTL98vMojDZtPFROL7yzKAAkuwF7MrpzXffQSomKIp0MsNlFbe3ucjOtH/hOInjD
         HT4hV3dUoNOWdgU2+VrD0niOZU8RDhYmT4M6Sz3vkxz8uNl53cUty8frMU2WtJuMnm/U
         N2VANZ2MLeApumKbnzazGM8B1lxAm2lovOiPVURlxYrOxZlDww5jd/9iVJ8PXJqdpXur
         LShLGnQscLSLrvSZno/Vqlse+deZmsAlJFK3eRlz5/TcVrueArvZPRRk/gFn5xzSpCYe
         +7IJq+5qZ7rFWfydgKUirSv/dG6XNrrZhdT2EQ417VOAn5/d633BBCAWzdj7j5mmkF+J
         Kl5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691165124; x=1691769924;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ox8Iga73YVuYG7AbvArZALqGxDCiOsgsOfD0SAAN2aw=;
        b=Om543I3fnDfWXyWU84+RCoVe+sMd23rnxHO/u8XA/4YOgbo1YbtOKPlsVE7VOblNvY
         OaU6l+PGCSY3yJOzt+q7PZnoGkn+MDXTw1sOsgmBA8FONUKo3T+0jkT+jEp2RKhngmP7
         5IqiWITeb7wqtQ6xq2wXKAKySGnY6NudckX+JN/0E8B0iC13O9j7kxc/n4O9ysgHyO8J
         Ip9ktCCdoifs7VecMB5eUqKQ7YVnvjOs8N/EJxt5voJ6FnYAZfFsL8HVFlyJ8JT++9iZ
         G8xZ1tL0E5hPAAICKzAZImxooZm49h5+Ntti6uzPkUEQgPN3TkcO8xFAOU4bwqNZBsRD
         uPVQ==
X-Gm-Message-State: AOJu0Yz6Ht/v50sUT7bZ5hbvdgj2whRF58C2rfsGPcCSSjBhBjKIhEfq
        Maf7CyniPFrfc5by/SJKRS4ZYg==
X-Google-Smtp-Source: AGHT+IHHk/v2jjUyrx3GaDx38eWLyd6yfqNnQpWrCXoIz3KI9OmMFfu96D2Q1NM7SUuF5X1sdm9Kgw==
X-Received: by 2002:a5d:67c6:0:b0:317:393f:6e6a with SMTP id n6-20020a5d67c6000000b00317393f6e6amr1537552wrw.59.1691165123848;
        Fri, 04 Aug 2023 09:05:23 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d670b000000b0031753073abcsm2823192wru.36.2023.08.04.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 09:05:23 -0700 (PDT)
Date:   Fri, 4 Aug 2023 19:05:20 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH v7 5/7] nvmem: core: Rework layouts to become platform
 devices
Message-ID: <3a4aa779-f8b8-4178-8d65-b6aae9183fb7@kadam.mountain>
References: <20230801182132.1058707-6-miquel.raynal@bootlin.com>
 <b9040273-aca8-432a-83aa-b0d6b1b88529@kadam.mountain>
 <20230804173903.2b298cd3@xps-13>
 <20230804174625.4c27fe9a@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804174625.4c27fe9a@xps-13>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 05:46:25PM +0200, Miquel Raynal wrote:
> Actually of_nvmem_layout_get_container() already returns NULL if
> CONFIG_OF is not defined. This helper returns either a valid pointer of
> NULL. Where can it return an error pointer?

This is from linux-next.

include/linux/nvmem-consumer.h
   256  static inline struct device_node *
   257  of_nvmem_layout_get_container(struct nvmem_device *nvmem)
   258  {
   259          return ERR_PTR(-EOPNOTSUPP);
   260  }
   261  #endif /* CONFIG_NVMEM && CONFIG_OF */

regards,
dan carpenter

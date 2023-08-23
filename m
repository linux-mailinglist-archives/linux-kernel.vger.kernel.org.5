Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3C85784E72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjHWB4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbjHWB4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:56:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126D6E4B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:55:57 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-68a3582c04fso2113314b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692755756; x=1693360556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fRkiScFMOgu2DA/fAKYSlm8Q7j2pyGv/X1yC33C77yw=;
        b=HAGOCxI6iSypFKwhotPIf5nC833CPY2kkuxhaLKQ5oJYz/hNBnAJ5WfPzvubuIYCJH
         GgwWnGqiDJG4ZhLw4gmuXLZsWebzsCvpxs7ffjZkH5Mhl8FkhubgtJBYvHAKgVdoyH/d
         5hXDGREcRSxo0nlATiixeAn1ZjUlOzv8VGpPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692755756; x=1693360556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRkiScFMOgu2DA/fAKYSlm8Q7j2pyGv/X1yC33C77yw=;
        b=HOpwdtg96yT8LzHMW8eJOikaJoymhXEogkHwCfJ+YsK5Yrv5RQ0DO6EFdyliZthiNp
         4Ok3p4B5FBV5snwiV2blMpvhgeYfA2u9u+4awb9rw6LKpVHZqE6BPFCdOYMVPCTXL1ii
         PaJ7fyKw9+xGVdZcIqZJgDuk/q066Qrftpl6KgCacp0yScXhWpOMvsfImFNiPiTBBN5C
         AeDNhQCUqTcUVhs3TCdnJ3n3ElicE241Y6rBZl7yoPHt+oMyw36tmIh2/Nnxva6ks81a
         3woLIC2yIbQYY5m/dZBtjz+lY9BUU/8WqInRh8OCZ8gIJBa0uAocY2zh+1Sia67tJuT4
         aIlA==
X-Gm-Message-State: AOJu0Yy+fALbYwIRBR+MTDhafUdJqiNQe3inyavqlwClmTNBpHmcPnjx
        8UvoVUteBSO6De8dB2e1EXpiUg==
X-Google-Smtp-Source: AGHT+IF9DYgiYQneYQNwX7Ayy+tzBw9tZVdJ5vCPBzs3OK5K5JOJFUBVa2o7P+C2g86YTNuREqWVUQ==
X-Received: by 2002:a05:6a20:72a4:b0:133:bbe0:2ff1 with SMTP id o36-20020a056a2072a400b00133bbe02ff1mr11542589pzk.44.1692755756380;
        Tue, 22 Aug 2023 18:55:56 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902f7c900b001bbb598b8bbsm9684771plw.41.2023.08.22.18.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 18:55:55 -0700 (PDT)
Date:   Wed, 23 Aug 2023 10:55:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ying Sun <sunying@nj.iscas.ac.cn>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, sunying@nj.iscas.ac.cn,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siyuan Guo <zy21df106@buaa.edu.cn>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jesse T <mr.bossman075@gmail.com>
Subject: Re: [PATCH] kconfig: add dependency warning print about invalid
 values in verbose mode
Message-ID: <20230823015551.GB3913@google.com>
References: <20230809002436.18079-1-sunying@nj.iscas.ac.cn>
 <CAK7LNARH-ziDD8=+90y5Zzo0cqqnc5qaiVWW0YQzdZ=nO9+e8w@mail.gmail.com>
 <CAJFTR8SajdzT2kKscEpPon9faUa8tHrvYPC_+awG3VeHVS8sSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJFTR8SajdzT2kKscEpPon9faUa8tHrvYPC_+awG3VeHVS8sSg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/19 22:40), Jesse T wrote:
> > > From: Ying Sun <sunying@nj.iscas.ac.cn>
> > >
> > > Add warning about the configuration option's invalid value in verbose mode,
> > >  including error causes, mismatch dependency, old and new values,
> > >  to help users correct them.

Are those really errors?

ERROR : CLANG_VERSION[140006 => 0] value is invalid  due to it has default value
ERROR : CC_IS_GCC[n => y] value is invalid  due to it has default value
ERROR : GCC_VERSION[0 => 120200] value is invalid  due to it has default value

I'm using clang, so corresponding options are set accordingly in my .config

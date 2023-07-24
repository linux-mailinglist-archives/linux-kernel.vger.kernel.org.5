Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFA75EAEB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 07:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGXFim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 01:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjGXFik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 01:38:40 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD48186;
        Sun, 23 Jul 2023 22:38:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-666eec46206so3791429b3a.3;
        Sun, 23 Jul 2023 22:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690177119; x=1690781919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0O+zqek4aroJ1gaWng0knQ8HoCxw3ZVY5JHWSMFwAtU=;
        b=V5iIIvaLLIEztxm5S+YYwfPN5wg0VLDo1I6RESsGPoo0ESNcUmJ1LGW2NVgteYkC9S
         JTKhzh6GRg1DEnQD70+0fhZbul9duRaM5zxbC0PonYj5swp6BYTLmE+u9z7J48BOorQ8
         k8VcrteNBDizPHaOHGZ3Ckv7hU6u4B1YS5Iw130TRCnThip85gGIG6nB9u1DJpL04LHd
         6Vm/jiGDFzOx3P+7TZllGzp6rk0o3pSwGRVbJ1zftygcdpSV3ZQBFEWIS0lXvQbzeUdc
         j+bJimf5YZY9eGUf62CZcE2BRuadlkWK/zvnuHPlO0iYa8XTFLrxkTxgWsrFDHFwgTcw
         GLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690177119; x=1690781919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0O+zqek4aroJ1gaWng0knQ8HoCxw3ZVY5JHWSMFwAtU=;
        b=fuE1KuaqTMouzw0aVHeNikdV9rWRPTWj8x4PbSXhrVc819cUhCTB8V8PeBbnBrh+OA
         bGPwy3UCBOVwcBMdfx9o7LzEv5VMae9PtQjxNIJAh/MwfT2hggDfbNTW5r+MttKC5kM2
         s7BsKrBQ+FsUuc/2LjJrCR/wcxMUrbdS3j0I/NlQKgZr+JS7fNW7HDxBAD2kLyGWgHTe
         La95mDCvWPoifOhazSY8x1uboV/0evbsb8eTLSNfn6wFKAXgKpn+yQhQlgOrKTbfyJtw
         Bm2mz4FAcaXXaVNziBFdNsQtnM5Vv6bkXDlG6H7haK/awcwVHe6fJHeJvZNdj/S3Yb+2
         XQYw==
X-Gm-Message-State: ABy/qLZ0Jcj1nTiS7MZEo0/n4M6zjyoWQ7hofy1jDvfk4CcDM8OJabHv
        awmSUZ6vsbQglC8pVuoiZTAcQwHbIS8=
X-Google-Smtp-Source: APBJJlFWvoEVf3bGlvlCe586neaemtrRJy0/gjZrxCd2hVBWU7qvTklGFXs9T2J+W9GzStCRMeMLWw==
X-Received: by 2002:a05:6a00:230e:b0:66a:5d4a:e47d with SMTP id h14-20020a056a00230e00b0066a5d4ae47dmr10191222pfh.8.1690177119130;
        Sun, 23 Jul 2023 22:38:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b8db:3c3:1ff4:2ae3])
        by smtp.gmail.com with ESMTPSA id c5-20020a637245000000b0055386b1415dsm7569587pgn.51.2023.07.23.22.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 22:38:38 -0700 (PDT)
Date:   Sun, 23 Jul 2023 22:38:36 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] Input: tca6416-keypad - convert to use devm_* api
Message-ID: <ZL4OXBuAbYGH7sIy@google.com>
References: <20230714080611.81302-1-frank.li@vivo.com>
 <20230714080611.81302-4-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714080611.81302-4-frank.li@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 04:06:07PM +0800, Yangtao Li wrote:
> Use devm_* api to simplify code, this makes it unnecessary to explicitly
> release resources.

The driver needs bigger facelift; I posted a series addressing this
that incorporates your patch.

Thanks.

-- 
Dmitry

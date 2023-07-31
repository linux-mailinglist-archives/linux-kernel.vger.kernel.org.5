Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8ED769C20
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjGaQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbjGaQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:18:54 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02797A7;
        Mon, 31 Jul 2023 09:18:53 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-267ffa55791so2613866a91.1;
        Mon, 31 Jul 2023 09:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690820332; x=1691425132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGIzVhnJPbm+Nw+mt1LCyglB+QvUWCQ9474FaGPAigo=;
        b=VdZY+kXtGJwVpHXJD7caV6QNH7Ee/ilU4EvYrzONNg3QKG7DrSu8mcBhDjAet8bBBz
         CY7QBiD5WBB9WGjh7omoQ79zzTMoz6OIsULB2hy//LBzzdbzvel2hT4VDQcsdgRERrvZ
         C3wFGpiMPJwVTbalEdKf7GciyVMGRmG+1TJjlC3cQ1FClEhvbpNGfiCDmtLyK4qegy91
         r7OfFkSq2Mb6IDi3KRMc+05Tfqg4lSfI9EUJvc17EpEqixMDK5N4joaI67Ov+oIZY3Ts
         zEseng6qeWievYXHaodtEH3wbDYZzhSHThpiCx9G6FdennlVkqG7jaZngSSN4+2VX+f8
         TWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690820332; x=1691425132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGIzVhnJPbm+Nw+mt1LCyglB+QvUWCQ9474FaGPAigo=;
        b=lXQLLrf/81kYyYOhjbs+sjOjblY7ZoZYqjhFRYfzxa4bRGGsDP0qEhb5rpTQiJXIlG
         DdBn1VWUoXJxg+Eb75odQro1KlCL3PY6uof0rokXuSi+z6/pSOpzvrWtE8uNWNUnh1/s
         3Gp8grSSrJhQ4aRWr1gXLNTGAEjrpKzKOxYU3farFDEqKH0BbemjQiguQETr2qFMT2Dm
         baFvBf8cA8nBHSNzfEh3RWfL6R29nuYbeyu/ElxpbvR+Vw2yV2wru5maluVC/YPU+/RK
         zK/Fy674q5H+IsoDVKnXUnqXg/VD9tpcZUbdlRpCjAWq7/vJS0A7cd3BzBy4ijxFRDSl
         yJUQ==
X-Gm-Message-State: ABy/qLYAsKpbqCVeQM5BSA4tQRSz/rb/1dFbMt3b7a6r9WPHgRu3edRp
        dr6EflfgiYGxVJrDtx73jxQ=
X-Google-Smtp-Source: APBJJlHqgN+TetC9g6IVIv9YNfULp4eS8gpke4gHB71X+/4e9AUl1WeMZbj1EumDThjJ1RxQGVwGDg==
X-Received: by 2002:a17:90b:1917:b0:268:1376:d501 with SMTP id mp23-20020a17090b191700b002681376d501mr8597401pjb.5.1690820332278;
        Mon, 31 Jul 2023 09:18:52 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:6d25:c0f1:d8d5:201c])
        by smtp.gmail.com with ESMTPSA id bu5-20020a17090aee4500b00268dac826d4sm787380pjb.0.2023.07.31.09.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 09:18:51 -0700 (PDT)
Date:   Mon, 31 Jul 2023 09:18:49 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 04/10] input: serport: remove casts from tty->disc_data
Message-ID: <ZMfe6YCPiyjzJBoe@google.com>
References: <20230731080244.2698-1-jirislaby@kernel.org>
 <20230731080244.2698-5-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731080244.2698-5-jirislaby@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:02:38AM +0200, Jiri Slaby (SUSE) wrote:
> tty->disc_data is 'void *', so there is no need to cast from that.
> Therefore remove the casts and assign the pointer directly.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

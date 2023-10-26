Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC4E7D8BB5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjJZWdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:33:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FE9CC;
        Thu, 26 Oct 2023 15:33:08 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c5b7764016so3624231fa.1;
        Thu, 26 Oct 2023 15:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698359587; x=1698964387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4SxxJeIJ67UJRuWmX2lMM5UOUmBZb18yNZTZPQByIAc=;
        b=hWyLCFagPwWgcBx6FhIiF/450QNh0b3zOe4T8LA4dwYLghdPyq8zmRQ5+fUbSbN0SA
         9BP2eS5R6btFtNthFQwQh4wnoPQ9qz4Et0e1lV1gno9IdRMRoUc1UqiyVS4g/mccfmjF
         X+NOjcp3qgNFaBgfQP5RVehEIME3qZuAPi6xO3tVtXSVV15M5aieBcRV/4+xgmrZYK8L
         auBnHjrR9QO+x+rqPHmUChSyB5EsbDi8CmxEv5Ug19QdvRBIP4jHHlTeZFNBi4obqbDF
         +0JbukPallllMMyzUinR1bpNVm7jBXjvB9OkkNGZIWeEldVmtjKIjprv892ycwedamco
         sd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698359587; x=1698964387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SxxJeIJ67UJRuWmX2lMM5UOUmBZb18yNZTZPQByIAc=;
        b=bRC8G085ULevVGrGzxe34LefIajP4DM+2ERW1dJpWeGKsfOS+7/O07lKyATExLg8gP
         pUF+rGAqzlMXPmjolAG4L/NnIqS+ldogZBbV3TXb99t5bHbqOAnGuicG5Y8qK3wiK16U
         ORQIHuMfO9K7BWeUpxocfPIw9/vXhRouigfRPKU7MOJsli2JfMoLXG7KV13nGg4ui9AO
         bnxcV0MZ9+NdobzvQYwPfNay00pKT+DU3BpgLin9CTPvm2E4RS1nvas+/MiCCkbkes7n
         ll1dJEiKIzusK+jDrKP4nlxMVdBPVqZSwXOkemMy7rdbPkUf4DOl6bnwuIePG2c3EPrx
         ZVGA==
X-Gm-Message-State: AOJu0YwcCFCrawUbI9MaI2SpEjEbqx+7aakMNMvLc1UAkQPmRtdx3GL3
        6rVE7OCBAqGe7/pbdYPrn/8=
X-Google-Smtp-Source: AGHT+IHiJGPvEvNoYxUZFXdVNhDBLZImmPXHiZgnA1Uzd3w0qnIN0A97ELhuaXAvDjdWP1gQ5bRUUw==
X-Received: by 2002:ac2:4a64:0:b0:4ff:7004:545e with SMTP id q4-20020ac24a64000000b004ff7004545emr494644lfp.4.1698359586744;
        Thu, 26 Oct 2023 15:33:06 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id f24-20020a1c6a18000000b004063977eccesm3534864wmc.42.2023.10.26.15.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:33:05 -0700 (PDT)
Date:   Fri, 27 Oct 2023 01:33:02 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     GR-Linux-NIC-Dev@marvell.com, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
Message-ID: <20231026223302.4gjjeh7inn3a3llq@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
 <20231026221206.52oge3a5w4uxkkd5@skbuf>
 <CAFhGd8r-u193pBk2+WWF+sHWEo5ixxEiT=fcSYiuy5W+aWDsbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFhGd8r-u193pBk2+WWF+sHWEo5ixxEiT=fcSYiuy5W+aWDsbg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:24:54PM -0700, Justin Stitt wrote:
> There was some discussion here [1] but AFAICT I need to use EMACS
> or configure my vim in a very particular way to get the same formatting
> 
> But yeah, look around line 7000 -- lots of this pattern matching code is
> pretty hard to read. Not sure there's much to be done as far as readability
> is concerned.
> 
> [1]: https://lore.kernel.org/all/137a309b313cc8a295f3affc704f0da049f233aa.camel@perches.com/

Hard to read because of pattern matching is one thing, but your
indentation is unlike anything else in this file. There are inner curly
brackets which are less indented than the outer curly brackets. I cannot
read/review this, sorry, I hope somebody else can.

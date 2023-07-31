Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495EF76981E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjGaNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGaNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:51:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8DA1BC9;
        Mon, 31 Jul 2023 06:51:19 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-790af3bfa5cso7887839f.1;
        Mon, 31 Jul 2023 06:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690811478; x=1691416278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x1JzV6GUSe9rQZmhMtLwoQHtD9c7TLf7UjPpxZY/MaI=;
        b=n2bxSfoDP7CWENJHS4YzjUYoeOqQ/cc8YXwgInspSHuLFoMCoCHtR7ERGHLBLt4iL2
         t8yh5Js7Rsh1reHYNVtrrMnSnN0khNBULPki/mHAqj1Hd0mQ+5WtBXIZ3y0Xo4zB00MV
         LllP2kSFv8vVdD961ZM277H6YCKQkJ+0V6MOVKMuDwtur1brOc3s4pe4OPiPV+nGlDz8
         9fya1ywnXAoAilGt5KqwUrdMHtU11+eDuxPk4DLJw7EcJ4c8ekhk1X3bbOK2WjK0SWEs
         xuZXM0LdzI95QKwg8TRTAuwXoF48YiOF2kFXacou6cp7fGjC0UxUDlauGI5pNHUammWO
         KNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811478; x=1691416278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1JzV6GUSe9rQZmhMtLwoQHtD9c7TLf7UjPpxZY/MaI=;
        b=ewfdVP6R+zpzxW2f9rExf04HHx2WJWoU+NZevpdBQeVnccjRnL3DDVw4/df220ZmQw
         T7ADESR7VIzhVT516kBzGpmUVFp5/y5B7kUGt7t1dppIh8bdi8IvwweZKasSq8/V25z6
         B5IG/6HnjX9ttIUuzN/rgUSRKw0vRdZn8B3voQI9S1cOCLRjHqbyPOylYJyBrJ3/DKIq
         nCVQKnYJ0vbObQNd+Oy6VxVB6bEOkTX54cpKI6dQIxxm04b1oNXl5GhoCwWSHT/LWXO4
         3kcirJvgiXf8jh1Mib0Fixe2QCa5flnaGwJYP+fbaxqO8X1lt+vipIDkElAFFioBBjqC
         YtkA==
X-Gm-Message-State: ABy/qLZ1sINMrFnLiwmF/v9SoN5XjOVTqaV9MHMpW2nhM7j2ACZBxjqN
        xkX2lUgxe7RjQSW8cquiruNDWCH2ah8=
X-Google-Smtp-Source: APBJJlG6s4h+v6I6X2HJ2xJCzgaHfBjsbMPP9snvDia67KuSlKu5EvHAyjLs/a4S75FELvVYjWQnyA==
X-Received: by 2002:a92:d844:0:b0:348:d2e9:399a with SMTP id h4-20020a92d844000000b00348d2e9399amr5811462ilq.1.1690811478156;
        Mon, 31 Jul 2023 06:51:18 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id m14-20020a638c0e000000b0055fedbf1938sm8095694pgd.31.2023.07.31.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:51:17 -0700 (PDT)
Date:   Mon, 31 Jul 2023 06:51:10 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Subject: Re: [PATCH net-next] net: lan743x: skip timestamping for non-PTP
 packets
Message-ID: <ZMe8To+Rw0/pcjLv@hoboy.vegasvil.org>
References: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731125418.75140-1-vishvambarpanth.s@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:24:18PM +0530, Vishvambar Panth S wrote:
> Currently all the RX packets are timestamped and the timestamp is appended
> to the RX packet for processing, this reduces RX throughput. This can be
> optimized by timestamping packets only when the PTP messages are received.

No, you should not do this unconditionally.

Instead, you need to dial the correct setting based on the
hwtstamp_config in lan743x_ptp_ioctl().

Thanks,
Richard

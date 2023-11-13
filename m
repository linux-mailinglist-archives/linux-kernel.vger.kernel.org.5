Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29C37E99A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 11:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjKMKBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 05:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjKMKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 05:01:29 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F400010D2;
        Mon, 13 Nov 2023 02:01:23 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso51128821fa.3;
        Mon, 13 Nov 2023 02:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699869682; x=1700474482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdsSQw38vLtSwJ9r3hzpc/W0dWcVuWj091FNrQ0Ha54=;
        b=ZMaPYB+fA/UhP50m2LUF0qGBhNzaLWuKZjRFygCgQl8ne5NfiFYtBG8I82jOHaN37J
         5NPEuRhRNIK7xgf66hyiYFuTnaaV36m28iy2ErcBSG0Qjcmvcbp7ixLwhE5L+6owcLsH
         ZDZIU8cjr+0JEkjSrRO5ithMU6TorL7kPiyGVjobO5wOlRRWTKaTrjXONdCRF9wyc+xN
         8ng7jznr7z9TH2hNM4is0wvJK0QZmmTBpQMBI8A3FaZxaNJ+r4tDW0zEcayQUriv2zGO
         dsL1+zl7gTN44AJSzwvncSf0rA4CvXc1YWSkkvjsTJS355yVaJUcZU7lk1sCGIlbxLiI
         orWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699869682; x=1700474482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdsSQw38vLtSwJ9r3hzpc/W0dWcVuWj091FNrQ0Ha54=;
        b=TTWmlq4N0qG5QIsOezENOzb1Nd3d57I699w7aKDuCug/cb0XnOLwThTWS5gzlVaQFN
         cv2Vg8Cde9hMF/yxq+wLRgSLa+rBkoERo6ed53LNQ+ZMdFfghHlh7ejC1bqTRrCOnjjx
         b5UD5rZwsv4l63JCp9nCXeJTr5/ELrkK649aEMYT0tV88MWL478tnxlEtL7k677GHUaG
         5SqffvG0c9BBqqJhUhN9+mft3C7G+CFOVQRhZz0S87692La0+RYMxJ+FcWJLRxSMAiS/
         3zWvPa62vo8QOLLZnOs+IfWJSGVBUdbx4AU8qdDpezKaRtsUhlPDihhCngsKHkwYVLOg
         sM5g==
X-Gm-Message-State: AOJu0YzkHll/yvP7ax7MCNAqQWf7f6lwKM4dLWK6Gzu7BCN90SkNAb1v
        SRo/Ax+tN4HVIu7P20n85J4qqmv9Qn8=
X-Google-Smtp-Source: AGHT+IEw8VoIQ18ELfNiZetCsAcr4BJZestX+7pXdLiNEt3ED9bDUfee3EMcFopYcKhp6LaH35IrxQ==
X-Received: by 2002:a2e:a303:0:b0:2c5:1603:9c48 with SMTP id l3-20020a2ea303000000b002c516039c48mr4773031lje.20.1699869681895;
        Mon, 13 Nov 2023 02:01:21 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e17-20020a05651c04d100b002c50ba4a047sm934976lji.80.2023.11.13.02.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 02:01:21 -0800 (PST)
Date:   Mon, 13 Nov 2023 13:01:17 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Jan Bottorff <janb@os.amperecomputing.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] i2c: designware: Fix corrupted memory seen in the ISR
Message-ID: <tupjmogut45oh2t2cth7o5wpqc6u6qkwfwddqrfnozlpplavlz@vram3ul3t4zj>
References: <20231109031927.1990570-1-janb@os.amperecomputing.com>
 <yuperxjytpcwz25fofjut2edzjc4i6jgymcraxp4q6mfe27taf@b33ym5iuubji>
 <ZVHxhN+dxJSUkEOg@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVHxhN+dxJSUkEOg@shikoro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 04:51:00AM -0500, Wolfram Sang wrote:
> 
> > The patch has already been merged in, but in anyway:
> > Tested-by: Serge Semin <fancer.lancer@gmail.com>
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> Thanks to a restrictive hotel network, I haven't pushed out yet, and
> could still add your tags. Thanks!
> 

Awesome. Thanks!

-Serge(y)

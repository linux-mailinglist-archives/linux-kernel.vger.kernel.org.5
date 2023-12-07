Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4152C807D88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 02:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441957AbjLGBCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 20:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441924AbjLGBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 20:02:42 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8DEE;
        Wed,  6 Dec 2023 17:02:49 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so274116a12.0;
        Wed, 06 Dec 2023 17:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701910968; x=1702515768; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0ZHx2dTpeeD/dzT9UX8bmnVSTh3P7Zoy3W1EjS6Yvs=;
        b=PgXklL5DfrY+z2Sojg4K0GhWAcv8yGpLesQA9JLBMLz8FL9iINIhDv5m/zih91q0Ul
         buasSlbpFsKmM0sjOpImIvsqkhu6JdGtgUY3HYHvYsmGxGULNFI9LPq7l4ZJsrGj+PGi
         Gkx7cbQc8snT+K1NbjWi7eYEEd6L13rkHIGrdmCZNBCyBSvvYSxwizZ4b6FZ5lGQtO6q
         sd12Z2uwcsdUx0iE33sxFEEmNtx72M5k2aHDIKPPVqR0KKIkWjh9a8IMyjcvWj+r1cex
         UkZT22jxmit3LpaQhw81vgnTp3xUOSN1fa+MNs2p9QTKDgjl3839LcaTPGe/VS5z13E7
         X0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701910968; x=1702515768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0ZHx2dTpeeD/dzT9UX8bmnVSTh3P7Zoy3W1EjS6Yvs=;
        b=jbclxm5/S1Pq2pSzYd5NSwdBCOjJ42ux2yVVoTlT6CvXHSvsCIyqv0XW1ZuzDAXXs4
         y6Z2JzWpcGnoScWb6joQNbMBbKXGi7oLZvpqjHyd6iSBhfN+JLFTvhoFORh5yCim53m+
         StFpgf6TjNjqNUM1G4iTPSzWoBzzQEoOqljaiLRWL0YOw4VHPPSrFO/EeL6wtODm04Zt
         h5xx74d8L5ECxWADtQdeD8iOuFIo26PgoHwHh3Kp8YRkzlK1w2YSsLUo+Ldtt0WmoHew
         h6r4Ua952o3I6LFb7RYH4GiiPDg7XsHI63rdmoXB/4l+0hfnfEW3LGzNi2W8/58sS/gt
         c6CA==
X-Gm-Message-State: AOJu0Yy2Hq26IGayBDIJEePGIB84cg2enyWxGOYJpOZBV3ERThCGYDDB
        xR2E+YbcsVb4AWV9XNATU3U=
X-Google-Smtp-Source: AGHT+IF0NVXLnlslRkPt5reTco4DlgSrpI8lg5XgES8+5VA48tmxLztqsza/95Hxskb1PbsMxiLgzQ==
X-Received: by 2002:a05:6a20:9410:b0:18f:97c:825e with SMTP id hl16-20020a056a20941000b0018f097c825emr1268601pzb.104.1701910968337;
        Wed, 06 Dec 2023 17:02:48 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id fa37-20020a056a002d2500b006ce93ff8c7esm127179pfb.104.2023.12.06.17.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 17:02:47 -0800 (PST)
Date:   Thu, 7 Dec 2023 09:02:43 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Florent Revest <revest@chromium.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH] team: Fix use-after-free when an option instance
 allocation fails
Message-ID: <ZXEZs2rOUil8QH8Y@Laptop-X1>
References: <20231206123719.1963153-1-revest@chromium.org>
 <ZXCNouKlBlAKgll9@Laptop-X1>
 <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKK0F1F5SzXoUpG4etDz2eGhJoSZo56PHq7M+MNjcjTKA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:31:58PM +0100, Florent Revest wrote:
> Thank you for the quick reviews Hangbin & Jiri, I appreciate! :)
> 
> I just realized I forgot to CC stable (like I always do... :) maybe I
> should tattoo it on my arm) Let me know if you'd like a v2 adding:
> 
> Cc: stable@vger.kernel.org

I think Greg will take care of it. No need to send v2 when there is
nothing to change.

Thanks
Hangbin

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B9F7E0C12
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 00:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjKCXPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjKCXP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 19:15:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DFD75;
        Fri,  3 Nov 2023 16:15:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2802a827723so595400a91.0;
        Fri, 03 Nov 2023 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053324; x=1699658124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUbuLZZiiMqt8h7niCAP5iYDjZ6kaMpEpgDdEjnpTaA=;
        b=VBlEGJKzKs2T58Oqtw5ATxpwlkGQaaqRMA8UkxMzJRYIYTSA2Tj48iSxK0adWbVyfv
         lCuipHW0G8mx/0vx4+wr0dVzb7JFyGqwbmSU9Uud6rdcbTkelQ0YbhATRVnGj5c18PRN
         PEgHyncnBcAGqMwmBTuxs1lSdNnoaqxuqIYbDwAfkESluH5kKKUm5Rya2r4VhJrYmU67
         BckPZqliEQ3JUg/Jvok/YjMWbgZ1Xg64GVJGCHg/4LWLF2sZEdmUn6Dtc4Vr75phedaw
         dpl4tRLzJZUcUmqXSsPli6MYdRBoFACRQAzVZanPFM/VsqOe8N1xiKe/ik4WiOFTAQCj
         XKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053324; x=1699658124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUbuLZZiiMqt8h7niCAP5iYDjZ6kaMpEpgDdEjnpTaA=;
        b=QRsiQodLqkQZZ5e3F62RGNVtpl0KL/No7hynC5frM/erLvkov5jeEQRc0lniFIAR+m
         HW8Yi+WaD8JMKN6eO7zEt3wUWalCtg3QUd2bvnz7Gm87dSmScgUJ8jQ45sD6gKcnlAy3
         kpYRBLNC3MiRJl+PV7dI+xBojhfupKK/jZl7ugqzQ5jFyXzZZ3jCLckLgg+NIMY5MEjv
         ylBTwob2cAhx7btTiHHqwJc8eEW3lBkfW0NJgKtzfv0NCPdhKGpXebkKNnlmfhOuOLK8
         ucs1I3mqwh30DnC817tV391KA7sFZqMm12SmnLqSqWrI3NX07hhzT75ECs/AhIo6g9Gl
         HQww==
X-Gm-Message-State: AOJu0YwJrwSxIRSlMbj1QYsAkXnbNG/0janJvI7ngcH8A1DuUl15MgCT
        +iFHXiLfD1PUMYn6uDcnqqw=
X-Google-Smtp-Source: AGHT+IFGSdagiS8UoA75QxW/N8+9LLInHQ7sVrQMtQNdJWWK7/gq+5dm71BtD8OH8bjmeeu+HLWrHA==
X-Received: by 2002:a17:902:e2d4:b0:1c9:e121:ccc1 with SMTP id l20-20020a170902e2d400b001c9e121ccc1mr23406449plc.5.1699053323839;
        Fri, 03 Nov 2023 16:15:23 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001bde6fa0a39sm1858100pli.167.2023.11.03.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:15:23 -0700 (PDT)
Date:   Fri, 3 Nov 2023 16:15:21 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, reibax@gmail.com,
        syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUV_CYndqqdt4aY9@hoboy.vegasvil.org>
References: <ZULphe-5N0M5x_Kk@hoboy.vegasvil.org>
 <tencent_ACEACCAC786A6F282DF16DCC95C8E852ED0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_ACEACCAC786A6F282DF16DCC95C8E852ED0A@qq.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2023 at 07:16:17PM +0800, Edward Adam Davis wrote:
> The above two logs can clearly indicate that there is corruption when 
> executing the operation of writing ptp->tsevqs in ptp_open() and ptp_release().

So just remove the bogus call to ptp_release.

Thanks,
Richard

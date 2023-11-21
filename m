Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246287F355A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbjKUR4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjKUR4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:56:07 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938B912C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:56:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so8075761a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700589360; x=1701194160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA4AVc9wusU+6rRUqfOFOnbQWEj+co4/T/ukMhfmlOA=;
        b=O72JOhAMYHNP51q6iZdBjpc3Os0yN2Ka6WCpkneJFhM3AVDpfBnpaFMi3EdteZ+Ar5
         qy3YBZBtTXTU9gTBsEJgo6ARRYpS4v5h7baNnztzjZut6mvIZwUZEwjsPMGOffWPakNm
         EyBkS1jcX06G6gkl3FgZna6qFd4JmYVqTOvdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589360; x=1701194160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA4AVc9wusU+6rRUqfOFOnbQWEj+co4/T/ukMhfmlOA=;
        b=me8RSJxyKDm6K4fqf7yyrMtHo9B/c3TYPCb2ccOOQrJLqspXENG/DkgUn9uqK9wTlj
         ZmUOedEpk2EaR3abWrrMn3iGxsdA5t2pyC5R+OpxhKnTT+hXfFXaFVf2IsAMaaItibmb
         +1X/wDZrjHUh3E7SbmM7TnLt4m0u+/uC4A+uJLA8v7ywvzAOT5g5rlW4hiNJDOYg6zcJ
         PGKfAgyPFMhMvseq5DH65nCe5DP1N6u6xYk7LE+F4UBqyk0/JDHcBNcY48dJXrVpYr2l
         DMrCC9zdvbhDWAtIB8MOnW2nQ/r2EjH8g2n2bZH60d2E4A5dbljk5JNJbgympql1nH92
         eLpQ==
X-Gm-Message-State: AOJu0YyTKzBxwNgxO/V6qhBU0AY/7RzffQg57d+DUdgmVn9WlWDY/yYI
        ndeoh3tVy31CfRaRsQrnEfJ3FbQMX87OlzSe7nakkRQJ
X-Google-Smtp-Source: AGHT+IE/HG42DzRrs0+Sz1qifHbTLv31XPXAE739oR0nrHjzFCsivsBWXOgoMlLlnexEdtAoUO0Ovw==
X-Received: by 2002:a05:6402:484:b0:544:a26b:dfa3 with SMTP id k4-20020a056402048400b00544a26bdfa3mr68488edv.6.1700589360391;
        Tue, 21 Nov 2023 09:56:00 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id h6-20020aa7de06000000b005489ecd06f6sm3187663edv.38.2023.11.21.09.55.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:56:00 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40837124e1cso3335e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:55:59 -0800 (PST)
X-Received: by 2002:a05:600c:1c1f:b0:40b:2ec6:2a87 with SMTP id
 j31-20020a05600c1c1f00b0040b2ec62a87mr1361wms.5.1700589359277; Tue, 21 Nov
 2023 09:55:59 -0800 (PST)
MIME-Version: 1.0
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid> <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
In-Reply-To: <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Nov 2023 09:55:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
Message-ID: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Grant Grundler <grundler@chromium.org>,
        Simon Horman <horms@kernel.org>,
        Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 21, 2023 at 2:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> > Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> > the driver. There are still a few more that keep tripping the driver
> > up in error cases and make things take longer than they should. Add
> > those in.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think this deserves a 'Fixes' tag. Please add it.

Sure, I can add it. It didn't feel worth it to me since there's no
real functional issue--just that it takes a little longer for these
loops to exit out, but it shouldn't hurt. I guess that means breaking
this commit into several depending on when the offending loop was
added.


> Additionally please insert the target tree in the subj prefix when re-
> postin (in this case 'net')

Funny, I just followed the tags for other commits to this file and the
"net:" prefix isn't common. I guess this should be "net: usb: r8152".
I can add it when I post v2.

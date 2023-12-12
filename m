Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FB080E7EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjLLJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjLLJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:41:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72395DC;
        Tue, 12 Dec 2023 01:41:51 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2cc2683fdaaso14240131fa.0;
        Tue, 12 Dec 2023 01:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374109; x=1702978909; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aVLRsdYbktegNzx/Zud+ZtI8big1fblrhu7NGAxTQAw=;
        b=UhoSrJiGJ532dSxRZ2GtlJrhxqA0dRydAXdnIBka2HNV1twuSCEKnei3fPhee36NY6
         2joh0ZQMyfPIfYOCLG7HcWkyhqEc7YirrMNToT2UV0lLBOHk8mPsPfm6Gy2KLwre/2DT
         zAWtfD2iMNDgksIbPyExEb+5q4HvFOiNfKq1Ve+8IpId0TYHAOUaFb9DTi8y4hQM31QN
         2C6sxplfUCs2ab0QwOlUFLd1kI7oLy1J+7Vwj8QCN/EqS8xkjBU8SdFhlNtThpSRvFer
         aPITmU42fi+Q6SesVvTAYnWyF6DUR3qcC+26BJeSFecqL9UsPTOjVd6qivnk6nNiEyEt
         a0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374109; x=1702978909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVLRsdYbktegNzx/Zud+ZtI8big1fblrhu7NGAxTQAw=;
        b=tN6IQ8kSIxek428Gb/0NOXylznFtDN3oAJ8iwlKHdVXrrw5eR/sEWo0Dpiy1WdgJ9h
         Aw/nrL8q8Q1lmTQSg+XCHrV/m50NxAXtzOazOie3zFgcDQtNVaAXASof/nW/urBpll/J
         +LpA7dfDW6wDQTXPOsk6iIIsN4qcgZsBaXguQDjJu9fh4RwnH/vN9RhT9A9EM3p7kFUC
         ElOwS00JPWus5rwg4F60IWXAzLgJoijapFhQJAaTNCzLlSrxO535yKlvrkM0DaeGZBWf
         CHdTjztCwyFlP8vx/lLXjt4XPpumx4tQ149o3p9wWqUy2guShtd6IAlv76vSMjtHBD0P
         hYUw==
X-Gm-Message-State: AOJu0Yw6nnXDUnMjn0DdSbksbYQD15O106D01+48OMKrKFCjUE4g8fa9
        1wNHZuVxSNVHocWjwpBUwdPJyYP8Qo5P7A==
X-Google-Smtp-Source: AGHT+IGjFCbfOwwOutwRYz9AG4gY6Bjb3gwTl7okXn4Z2UZjyVCgGejFArR0xoCO2FepI8R+GuIWdg==
X-Received: by 2002:a2e:be83:0:b0:2ca:135:2204 with SMTP id a3-20020a2ebe83000000b002ca01352204mr4525370ljr.16.1702374109370;
        Tue, 12 Dec 2023 01:41:49 -0800 (PST)
Received: from dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi (dy7lrfj8vfr2jm7whrhxy-4.rev.dnainternet.fi. [2001:14bb:6d2:e21f:9123:ac75:6e46:71a6])
        by smtp.gmail.com with ESMTPSA id l25-20020a2e8699000000b002c9f16d5da9sm1477738lji.95.2023.12.12.01.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:41:49 -0800 (PST)
Message-ID: <d523ca40916a8c17ea8ab6d980265e2985e094b3.camel@gmail.com>
Subject: Re: [PATCH 0/3] afs: Fix dynamic root interaction with failing DNS
 lookups
From:   markus.suvanto@gmail.com
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Dec 2023 11:41:42 +0200
In-Reply-To: <2810523.1702371786@warthog.procyon.org.uk>
References: <59be73c8346ca0c0d6feddcdb56b043cfa0aea4d.camel@gmail.com>
         <20231211163412.2766147-1-dhowells@redhat.com>
         <2810523.1702371786@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti, 2023-12-12 kello 09:03 +0000, David Howells kirjoitti:
> markus.suvanto@gmail.com wrote:
>=20
> > Reproduce:
> > 1) kinit ....
> > 2) aklog....
> > 3) keyctl show=20
> > Session Keyring
> >  347100937 --alswrv   1001 65534  keyring: _uid_ses.1001
> > 1062692655 --alswrv   1001 65534   \_ keyring: _uid.1001
> >  698363997 --als-rv   1001   100   \_ rxrpc: afs@station.com
> >=20
> > klist=20
> > Ticket cache: KEYRING:persistent:1001:1001
> > Default principal: .....
>=20
> Can you "grep rxrpc /proc/keys" at this point?
>=20
different cell though...

masu@t470 ~ % grep rxrpc /proc/keys
23e16cda I--Q---     1   3d 3b010000  1001   100 rxrpc     afs@movesole.com=
: ka


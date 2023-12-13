Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C8C8107EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 02:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjLMB7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 20:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjLMB7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 20:59:14 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D6ABC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:59:18 -0800 (PST)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 021163F286
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702432757;
        bh=h+rBAEQoN+2M3shJlkzk0yJXe+dflPKE6126HwVLSm4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NE5fVrqWUXRYhsOj4zyOzg2/7QLlal6ases/cSn5rjYT2a59xV8Jio0U3cui45zMk
         kIvX9WjrG6PJhbTJvs7ZV8nSLMKGWlkrGOB9k9eIcfs5HUSlcUx6JXip8JNBKpP01G
         0XEMQoHnAr0+pwR/jFk3B6HVbDelXEpVvdDtWyqh4B833wQbuxVNCkSOcQd7s+IgTT
         TW7BwUSepkvuV/3RL5y6vNiy0c8F4EE09W2VfncpYjYtlpohA6jOS8qBw4bE9CRzF+
         /3yDgVMTR/BtL1g/BSNZBoYFptfkmQhYw7x/BFMHY7GbVeuZGm1zuIPAjnGCho31YB
         5AkWlvW/TYNwA==
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-58e2b7e4f94so8344229eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 17:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702432756; x=1703037556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+rBAEQoN+2M3shJlkzk0yJXe+dflPKE6126HwVLSm4=;
        b=TLjaaj90e0TX47w5dRIUynhJ7ZeOFGsdTGsWZVuNWEo/yAVqwMZaDRvGbqIhwuLYkl
         9I4d82w5b9d14cm39bOvuKlFVle0ChgmRjbFid3aWXt42ukTjCiYUE5XJhmLGLFwkEYh
         JwHZGohPpJP5X0RA9sqV5cqqBDv9rim6/7Afdrrc3yB3ImVLTH7kCxXXUGeZihbgahpP
         Tw/Dh0eqJS2b8ALAR/YwlCg7GjbMtoqs+wk5fyhrGa5YOjZzQIk8Zmu0ls89Mm9wv5Ln
         qGng43dLCF/K1ad9k6ocCS0HM/p6RPx45+1NQYEIHssWo0jgica85QSvFzsFwVawvlgf
         qyNw==
X-Gm-Message-State: AOJu0YzvbFbPL01YLJ66x0Al28K6vvKLqo2pwyvRjWsUCmW7K7PMr4H0
        jaUgagONkTE7gfHalQMwviKAnrNE7duZUEMWNTKz+NrADfuppbzkkOLMMFJnDO8C+Wk4nwuV9fj
        GoUVHmfuBT6ht2Z2sJnzE6XNTNhw222XS9cIMsqPVmhi9vs2gn79CDznXNg==
X-Received: by 2002:a05:6358:27a3:b0:170:17eb:9c45 with SMTP id l35-20020a05635827a300b0017017eb9c45mr9970513rwb.38.1702432755815;
        Tue, 12 Dec 2023 17:59:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVGVIpFGhZ31+0Gtn2n90aTHGRkaW10Hnysuv1OCKv/STHZS+/AcTiVm1fNJrknr9f3/yYiMTrMkWwLoLVEq8=
X-Received: by 2002:a05:6358:27a3:b0:170:17eb:9c45 with SMTP id
 l35-20020a05635827a300b0017017eb9c45mr9970502rwb.38.1702432755499; Tue, 12
 Dec 2023 17:59:15 -0800 (PST)
MIME-Version: 1.0
References: <20231212064533.233748-1-kai.heng.feng@canonical.com> <alpine.DEB.2.22.394.2312121441490.14041@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2312121441490.14041@eliteleevi.tm.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 13 Dec 2023 09:59:03 +0800
Message-ID: <CAAd53p7BEanFM-3Z257WiEZpnuLP+bn2owx19z0s7Vx2KZ8H0w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: hdac_hda: Fix NULL pointer dereference when hda_pvt
 is not set
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 12, 2023 at 8:45=E2=80=AFPM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:
>
> Hi,
>
> On Tue, 12 Dec 2023, Kai-Heng Feng wrote:
>
> > Kernel splat can be found on boot:
> > [    7.906438] BUG: kernel NULL pointer dereference, address: 000000000=
0000078
> > [    7.906449] #PF: supervisor read access in kernel mode
> > [    7.906455] #PF: error_code(0x0000) - not-present page
> [...]
> > This is caused by attempting to dereference hda_pvt, so check if it's
> > NULL before using it.
> >
> > Fixes: a0575b4add21 ("ASoC: hdac_hda: Conditionally register dais for H=
DMI and Analog")
>
> can you try this fix already merged to Mark's tree (merged on 7th Dec):
>
> "ASoC: SOF: Intel: hda-codec: Delay the codec device registration"
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/=
?id=3Dce17aa4cf2db7d6b95a3f854ac52d0d49881dd49

Yes this commit fixes the issue. Thanks!

Kai-Heng

>
> Br, Kai

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30547E4F46
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235032AbjKHDD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKHDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:03:27 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5B510EC;
        Tue,  7 Nov 2023 19:03:25 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2809fb0027cso4889937a91.2;
        Tue, 07 Nov 2023 19:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699412605; x=1700017405; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Roult3H5GeBy1d+QJ2ELRPfrTfU65zFDOPqiiV5RpBY=;
        b=XMosQJqhaK9LRLQd6lcmpo+oLUZvBLUtJJdK3iDPnB8+UBt7o5cECH6s0mIY+CIq+5
         5mTObbwRkW75CrlbkLcOjVAcmimYKvCG8irInw+4rWgBvb36kgPS5qfntoZZoWPjpsLE
         TTf8M53I3bxo1yB2uCufn17DvjjPyIidxJ5BCuoFrXE/W59GgqWpiDyhc0tWoHLxDKI7
         Fy071mZg3yg+cewfhNxW4gp4lQEMYE+adVL7zMrV75/YxKunT0ZqtWpALMuggxqIa0ge
         d9iEZDUToWsE+SaINJYAV9VoIb/F/A5RhE13KChH1tE6AFjEVdn32V5JHrfdcIy0LBVq
         SUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699412605; x=1700017405;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Roult3H5GeBy1d+QJ2ELRPfrTfU65zFDOPqiiV5RpBY=;
        b=nlt1f+KKdhQHCfUOJ3fwFOYDKzuTLvdqbutm4wrLuDS4Xbt2qQA453J3cmkm3csbmj
         ZJnvdw6D11pXL27iAaVo5asGC4fqKA92UyMMv7OmsK/8SNCBOiaN1ybMsnL2z6viIqqA
         M1FxOoAbs7x2cih01LzKBp9zMX/5TbZyOlDOLPx3AoBn8nDa7ELLpNtNIEWX1wM40Afg
         zi1Q3tsz39FjCpmd9M7fFnUi38OKPRGXvEZLNTqrgGjNk+GfgZvo0rhJl+vZgCNToqLE
         N+x38TX9jeZCWryL2VjbS71LUdbMTUhnSE2lXy4LNpAXhlX+M/9sjcTmowZjvlFdLFwH
         IWRA==
X-Gm-Message-State: AOJu0Yx6ncv9Gw8aksNzDJ4X8FqdZae1qseLtF8xzcS/NczrV71SyBQ5
        H+KNLxxEkqaPVJMiSdqO/rx9ne5ZqaOJOs+j2s0=
X-Google-Smtp-Source: AGHT+IH7qDbmtE7zwlbS/d/+wacRnaFS6GN+wV6OdZsWqrJ3k9uTLyzwcDfFQmcw4mIBiOc/1pOgoaBC+tNMnehaF0E=
X-Received: by 2002:a17:90a:2:b0:280:2438:120 with SMTP id 2-20020a17090a000200b0028024380120mr606164pja.45.1699412604862;
 Tue, 07 Nov 2023 19:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20231106141704.866455-1-zyytlz.wz@163.com> <87o7g7ueom.fsf@kernel.org>
 <CAJedcCytuGmvubqbSZgsU3Db=rg=xM+kSuLZn8BSvA18Yn+9Jw@mail.gmail.com> <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18ba5520da0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 8 Nov 2023 11:03:12 +0800
Message-ID: <CAJedcCxoL+L1QPaZty27k6kqR2JRjxPVY=BV5xn7BSPojbxe=A@mail.gmail.com>
Subject: Re: [PATCH v5] wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Kalle Valo <kvalo@kernel.org>, Zheng Wang <zyytlz.wz@163.com>,
        aspriel@gmail.com, franky.lin@broadcom.com,
        hante.meuleman@broadcom.com, johannes.berg@intel.com,
        marcan@marcan.st, linus.walleij@linaro.org,
        jisoo.jang@yonsei.ac.kr, linuxlovemin@yonsei.ac.kr,
        wataru.gohda@cypress.com, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org,
        security@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> =E4=BA=8E2023=E5=B9=B411=E6=
=9C=886=E6=97=A5=E5=91=A8=E4=B8=80 23:48=E5=86=99=E9=81=93=EF=BC=9A
>
> On November 6, 2023 3:44:53 PM Zheng Hacker <hackerzheng666@gmail.com> wr=
ote:
>
> > Thanks! I didn't test it for I don't have a device. Very appreciated
> > if anyone could help with that.
>
> I would volunteer, but it made me dig deep and not sure if there is a
> problem to solve here.
>
> brcmf_cfg80211_detach() calls wl_deinit_priv() -> brcmf_abort_scanning() =
->
> brcmf_notify_escan_complete() which does delete the timer.
>
> What am I missing here?

Thanks four your detailed review. I did see the code and not sure if
brcmf_notify_escan_complete
would be triggered for sure. So in the first version I want to delete
the pending timer ahead of time.
As I'm not very familiar with the logic here. I'm still not sure if we
should delete the timer_shutdown_sync.
Looking forward to your reply :)

```cpp
if (cfg->int_escan_map || cfg->scan_request) {
    escan->escan_state =3D WL_ESCAN_STATE_IDLE;
    brcmf_notify_escan_complete(cfg, escan->ifp, true, true);
  }
```

Best regards,
Zheng

>
> Regards,
> Arend
>
> >
> > Kalle Valo <kvalo@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=886=E6=97=
=A5=E5=91=A8=E4=B8=80 22:41=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> Zheng Wang <zyytlz.wz@163.com> writes:
> >>
> >>> This is the candidate patch of CVE-2023-47233 :
> >>> https://nvd.nist.gov/vuln/detail/CVE-2023-47233
> >>>
> >>> In brcm80211 driver,it starts with the following invoking chain
> >>> to start init a timeout worker:
> >>>
> >>> ->brcmf_usb_probe
> >>> ->brcmf_usb_probe_cb
> >>> ->brcmf_attach
> >>> ->brcmf_bus_started
> >>>  ->brcmf_cfg80211_attach
> >>>    ->wl_init_priv
> >>>      ->brcmf_init_escan
> >>>        ->INIT_WORK(&cfg->escan_timeout_work,
> >>>          brcmf_cfg80211_escan_timeout_worker);
> >>>
> >>> If we disconnect the USB by hotplug, it will call
> >>> brcmf_usb_disconnect to make cleanup. The invoking chain is :
> >>>
> >>> brcmf_usb_disconnect
> >>> ->brcmf_usb_disconnect_cb
> >>> ->brcmf_detach
> >>> ->brcmf_cfg80211_detach
> >>>  ->kfree(cfg);
> >>>
> >>> While the timeout woker may still be running. This will cause
> >>> a use-after-free bug on cfg in brcmf_cfg80211_escan_timeout_worker.
> >>>
> >>> Fix it by deleting the timer and canceling the worker in
> >>> brcmf_cfg80211_detach.
> >>>
> >>> Fixes: e756af5b30b0 ("brcmfmac: add e-scan support.")
> >>> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> >>> Cc: stable@vger.kernel.org
> >>> ---
> >>> v5:
> >>> - replace del_timer_sync with timer_shutdown_sync suggested by
> >>> Arend and Takashi
> >>> v4:
> >>> - rename the subject and add CVE number as Ping-Ke Shih suggested
> >>> v3:
> >>> - rename the subject as Johannes suggested
> >>> v2:
> >>> - fix the error of kernel test bot reported
> >>> ---
> >>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 2 ++
> >>> 1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg8021=
1.c
> >>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >>> index 667462369a32..a8723a61c9e4 100644
> >>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >>> @@ -8431,6 +8431,8 @@ void brcmf_cfg80211_detach(struct brcmf_cfg8021=
1_info
> >>> *cfg)
> >>> if (!cfg)
> >>>        return;
> >>>
> >>> +     timer_shutdown_sync(&cfg->escan_timeout);
> >>> +     cancel_work_sync(&cfg->escan_timeout_work);
> >>> brcmf_pno_detach(cfg);
> >>> brcmf_btcoex_detach(cfg);
> >>> wiphy_unregister(cfg->wiphy);
> >>
> >> Has anyone tested this on a real device? As v1 didn't even compile I a=
m
> >> very cautious:
> >>
> >> https://patchwork.kernel.org/project/linux-wireless/patch/202311040547=
09.716585-1-zyytlz.wz@163.com/
> >>
> >> --
> >> https://patchwork.kernel.org/project/linux-wireless/list/
> >>
> >> https://wireless.wiki.kernel.org/en/developers/documentation/submittin=
gpatches
>
>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39153765F43
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 00:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjG0WWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 18:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjG0WV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:21:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9E32D5E;
        Thu, 27 Jul 2023 15:21:57 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7589b187so2568036e87.1;
        Thu, 27 Jul 2023 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690496516; x=1691101316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5RV8/ahM+DUvJaKMceFZxwjrN0t9JLY7D20I2svw9s=;
        b=m5XSBNqMGx+saO8HB1KQ9lGLOSZ8Jw2PgDrnT5mE31Kksuj/DuIX4MnSQLWoM/WvQ9
         qf8C4CXamSVgmS0Bc4K7s9rmIFXVkvg24tl4MZe/hhB2mVg33zJc6A5MFW6cKife9AYm
         tfUnwgtZ/fw8jj0Y74WCW5UbOueASuOagtP4473j4SE1EvOr6XfGi60yF6sUwU5GIntM
         6PoXPSdFmePSkZtUYhvcvoDPqjR67/j+JyMVrq79SWWMpMlzd1gn68UGeFNGNW8FAUVp
         oDwNyHZse6JDMTTioEeVCpuniUUFO1tRh4VKdbbI+kAKtkhogIfrB68q2TQ51ciH5JXD
         570Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690496516; x=1691101316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5RV8/ahM+DUvJaKMceFZxwjrN0t9JLY7D20I2svw9s=;
        b=Vu/b3ITRpHRbuOWueOno5bNL1H8W4wspbHwu/jayJDo7Kp3lXm4HB4ZBygYzKUgV7Q
         P3JVlPv0Iq/1XcYq5Oj5RDC7B3wSM+hTtNulW6ZK8YkPBgTe0lCMwFD+aQTpMsgjZQT/
         RyhAVBphGCWqRtTT/6tRGGEzm0aqHSjjcYokD1PNnWqSQhTGvWXADoNSY9RrJso/XCoQ
         IR9HgfckV4R728pDxlh0Hw+Nrv08f/SONxm2rV0T+6cTyiAD8x6u8xAtfjlpIbNaJnIf
         +3ACsMqjACSywHibKv8/XUde1bk9alF9Tz4JZCSAlhit3cw556akj37Wg/m/GhkdjaYs
         pfwA==
X-Gm-Message-State: ABy/qLZ+/DDo0pdqTMvMK27NRIeYT8u44tm/niMBpaKwTp4RC0DTH62z
        Ux7Urtr84xJpSG/zRa5kfp0DAYQHb5M5v46XaJM=
X-Google-Smtp-Source: APBJJlGgdghveGc4LPwbjgWr6rCMeOEEwHaSD9Kk4Xp3udouUdBA6OEkFoqd6rjBNaq6reNj5zqvtnAtYVvpEAXT/Pc=
X-Received: by 2002:a2e:3505:0:b0:2b5:9f54:e290 with SMTP id
 z5-20020a2e3505000000b002b59f54e290mr263701ljz.0.1690496515604; Thu, 27 Jul
 2023 15:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230727013907.29068-1-yuehaibing@huawei.com>
In-Reply-To: <20230727013907.29068-1-yuehaibing@huawei.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 27 Jul 2023 15:21:43 -0700
Message-ID: <CABBYNZ+Fxmkxg3qQMABt-1DcvhMcUnqsOrwGgHXMQum5ezF82Q@mail.gmail.com>
Subject: Re: [PATCH v2 -next] Bluetooth: Remove unused declaration amp_read_loc_info()
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmenzel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

On Wed, Jul 26, 2023 at 6:42=E2=80=AFPM Yue Haibing <yuehaibing@huawei.com>=
 wrote:
>
> This is introduced in commit 903e45411099 ("Bluetooth: AMP: Use HCI cmd t=
o Read Loc AMP Assoc")
> and never be implemented.

The commit information above shall be added with Fixes: tag so it can
be properly backported, etc.

> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v2: fix SOB and update commit log
> ---
>  net/bluetooth/amp.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/bluetooth/amp.h b/net/bluetooth/amp.h
> index 832764dfbfb3..97c87abd129f 100644
> --- a/net/bluetooth/amp.h
> +++ b/net/bluetooth/amp.h
> @@ -28,7 +28,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, stru=
ct amp_mgr *mgr,
>
>  int phylink_gen_key(struct hci_conn *hcon, u8 *data, u8 *len, u8 *type);
>
> -void amp_read_loc_info(struct hci_dev *hdev, struct amp_mgr *mgr);
>  void amp_read_loc_assoc_frag(struct hci_dev *hdev, u8 phy_handle);
>  void amp_read_loc_assoc(struct hci_dev *hdev, struct amp_mgr *mgr);
>  void amp_read_loc_assoc_final_data(struct hci_dev *hdev,
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7927B5C88
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjJBVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjJBVlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:41:32 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A035BD8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:41:29 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c6052422acso26975ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696282889; x=1696887689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5HtBGQP0JtId3hysKoyET+d2eak3ivEB6hLZCtJ/pw=;
        b=o3eNFbbPoGd4lFQoNnQJA6QhO3N5Rs9L8lCwrWhs47ZUnV4iAJBMdhtqf2UatEWJvX
         iwZ0peE7wPNz+cWTt8RPTWsUHwZN2W3iG7vuxDGxa/V/5+2dzTmCVzym+5A5tacEQTEI
         tZycwXuGwZRO9f816x/cpzMGSbgtQ4OGaEcUn5m2im2W/gvgsM9X1H4/UKJ0ufPpGjcA
         7WarxjjwEa0EKHlTXas9+Mu/Leplr/ADIEN/+IwtKJMTnkx0mQ0GAkbvM7oYiSbPMqnG
         217C6Dx8tJJeeVU8S+GJXVMCJhP62Q/zzQ+8ZmiK3SOOCKshF/jcPKzkFMqGoR3LYB0z
         LiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696282889; x=1696887689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5HtBGQP0JtId3hysKoyET+d2eak3ivEB6hLZCtJ/pw=;
        b=ENC7TVUIUgdKXLBVqIGHzdJ1uvt1SHOEWqNN9afTNdeEnpQB+yBimeHoXBZmrZsPnG
         Isqf9awqLVcF8zoSQULTGZpexk8QKDcVgnaibEqz7Sy1/Dq7hP6E1SdgzPjUw6vMKIlp
         S3MrUP5eluUq5CdJBbY4HowNEezlS8WUOEGAf8lirj5jT+bnioDPTW9xJBVZmuzd9rH6
         fgcVXMZBHzkdH7U44RiKuKWAHBXaKa4UKpn575wHaLUFHSwmexwMv/U5KMnHRAk2twSf
         zus7G0T/TPaHvxNI2MdNOI9kILwv1WZiLuFJuLtUkhXTyNd/WF9Bf7fVF8P2Zd1w7jgP
         /vNg==
X-Gm-Message-State: AOJu0YwTbHPF9Q2Rmp4bb7sMk59WGYxGyfhFWS9Kw486oT/RJBqUAT6x
        4UurC/N3FGKV0b/aT7UfgSK89t8pxneENU7xouwpWQ==
X-Google-Smtp-Source: AGHT+IH7OIO9IQ7ddPlULJNi/8n2o2pnXCTPdEZWozBMwFUHLz9qFjdoNeBQTS4vy7asvsGfCrJPEkqlKa0NRl6CWxc=
X-Received: by 2002:a17:902:ab52:b0:1c6:112f:5ceb with SMTP id
 ij18-20020a170902ab5200b001c6112f5cebmr32045plb.25.1696282888713; Mon, 02 Oct
 2023 14:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
In-Reply-To: <1695781810-5700-1-git-send-email-quic_zhenhuah@quicinc.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 2 Oct 2023 14:40:52 -0700
Message-ID: <CAGETcx_+62Rt4fh0jM6stO2_eGPjtxaxVC=KxAei5XfBLq3_Zw@mail.gmail.com>
Subject: Re: [RESEND PATCH] driver core: Clear FWNODE_FLAG_LINKS_ADDED in device_links_purge()
To:     Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_tingweiz@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 7:31=E2=80=AFPM Zhenhua Huang <quic_zhenhuah@quicin=
c.com> wrote:
>
> Flag FWNODE_FLAG_LINKS_ADDED stops fwnode links creation. Current kernel
> only adds it once after fwnode links creation in fw_devlink_parse_fwnode(=
).
> After that even device links being purged, the flag will not be cleared.
>
> Fwnode links are converted to device links and will not be added back
> forever in normal case. Essentially if a device is registered and
> unregisted (also deleted) before it is probed (due to missing fwlink
> dependencies, abort in device_links_check_suppliers), the fwlink is not
> setup next when device is newly created again. This means the probe gets
> called without meeting all dependencies.

I know exactly what problem you are explaining, but it's low in my
list of TODOs because in almost all cases, it's a poorly written
driver.

> It usuallly happens in the case of a glue driver. Of_platform_populate()
> allows us to populate subnodes. We may do it in ancestor node probing
> function, then check subnode's probing status because there may be chance=
s
> that suppliers of subnode are not ready. We may further need to do
> of_platform_depopulate(which purges device links) and in some time
> of_platform_populate() again. Such case we miss fwnode links(so that devi=
ce
> links) during second time of populating subnodes.

Why is the device driver for the parent device adding the child
devices before it knows it can finish probing? Adding the child
devices should be the last thing you do as part of your probe.

> Fix it by Clearing FWNODE_FLAG_LINKS_ADDED flag in purging device link
> func, indicates both fwnode links and device links are absent.
>

NACK for this patch.

While the intent is good, the change is very wrong because it's
clearing the flags too soon and can cause a lot of busy work.

Also, this issue hasn't been fixed yet because fixing this will cause
issues in some other corner cases related to network devices. I need a
bit more elaborate set of fixes before I can fix this issue you are
raising. But as I said before, in 90% of the cases it's bad driver
behavior.

Thanks,
Saravana


> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  drivers/base/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b7d7f41..2a1975d 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1630,6 +1630,10 @@ static void device_links_purge(struct device *dev)
>                 __device_link_del(&link->kref);
>         }
>
> +       /* Clear flags in fwnode. Give a chance to create fwnode link aga=
in */
> +       if (dev->fwnode)
> +               dev->fwnode->flags &=3D ~FWNODE_FLAG_LINKS_ADDED;
> +
>         device_links_write_unlock();
>  }
>
> --
> 2.7.4
>

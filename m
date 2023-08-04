Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F12770994
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjHDUTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjHDUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:19:22 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E12A4C31
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:19:21 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56c685b7e91so1655128eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1691180360; x=1691785160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LhI1TckopnWEf5XDkW1FM4f454FUTILESy2uRfjAjOU=;
        b=Hov7m8RfcGJ17mD6Z6AxGNjRYucSDmQgHjcMdwMktabfeJ1SZYZ7rKRBbOTb/7p5/1
         NOjDqAwqTFtF+UubxDL3+4q2s/02SJJvNuCw594QD1jRMrjSC+WccJFRRlHPCaG4zjmW
         KDE+AYtzCrxnJM64mKkkU0mscF1000VTP8o2noZGYo2WMpGbdSVyYRTdJ+B2HntjPTCH
         VgqGal2Nz0s3lduGaWwAL2XTZxYKyhEDPyLYpq8RvTy42YxPZJQ0aMW1URV2ArxxSVE6
         2Zk4L3kDZH0QK3GOhADsC4G1vbT+oQeyYj3wKdvl5Wm7+qmtragX9AprBoVMHLyF6hA8
         Y/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691180360; x=1691785160;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LhI1TckopnWEf5XDkW1FM4f454FUTILESy2uRfjAjOU=;
        b=L0kkzPH/3A9F1BkOx7REQ71nL7xe/PmLwmuh9YvrdpXtmcxvw617QK77cR/rKoxbG1
         HYxRjo0j2h+j56nqYM9MkURSEa5f0ijhy5owyHQOl4CfEnBfhFOqU+7auGa3H8z3n9Q4
         TfnmVrvqyyxiPByL7PaDdoX5h7z2mJ1hBHJVWbFOUX7cclKVhjQsrqAeryThFPzNODkH
         c7NEh6j7JGesG1w1kbmqPHUjS/SfbGBfsFaFs1pSOwYhIIguAbGWTHVLCBedtk2I3BNX
         soLOfRvdxcQpgspg26au9kDna4JkftLSM2bS0YhUoVWnGzds8+oA8O88lpo5CRjCA0u2
         fabA==
X-Gm-Message-State: AOJu0YwZ4tIbD48G+YlyDNUNYXBNNR6VW9y6eN5KhTua4e8uJeOePZ4I
        JqBobdEQ+oaT4QOAU3LuWP8mgQ==
X-Google-Smtp-Source: AGHT+IFg1J2u131Po70o78O71dBBAEee9i2tzPE9wPv24P+BRAnVI56koGN7o+3Nap1CC0i1OfJJFg==
X-Received: by 2002:a05:6358:9894:b0:133:4ce:4e8c with SMTP id q20-20020a056358989400b0013304ce4e8cmr2940046rwa.29.1691180360210;
        Fri, 04 Aug 2023 13:19:20 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:bae9::7a9])
        by smtp.gmail.com with ESMTPSA id d8-20020a0ce448000000b0063d26033b74sm917150qvm.39.2023.08.04.13.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:19:19 -0700 (PDT)
Message-ID: <a42cadc2845c67357d98580e094a8d59c48f7bd8.camel@ndufresne.ca>
Subject: Re: [PATCH v7 2/9] media: vivid: Convert to v4l2_ext_pix_format
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Randy Li <ayaka@soulik.info>, linux-media@vger.kernel.org,
        randy.li@synaptics.com, Brian.Starkey@arm.com,
        boris.brezillon@collabora.com, frkoenig@chromium.org,
        hans.verkuil@cisco.com, hiroh@chromium.org, hverkuil@xs4all.nl,
        kernel@collabora.com, laurent.pinchart@ideasonboard.com,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        narmstrong@baylibre.com, sakari.ailus@iki.fi,
        stanimir.varbanov@linaro.org,
        Helen Koike <helen.koike@collabora.com>
Date:   Fri, 04 Aug 2023 16:19:18 -0400
In-Reply-To: <CAAFQd5Dn97Q-tSUvT5HncV0GTQQYrBYjF-1vsmB6VPv=zrkRkw@mail.gmail.com>
References: <20230206043308.28365-1-ayaka@soulik.info>
         <20230206043308.28365-3-ayaka@soulik.info>
         <20230713103912.favcnhqwjkzvsa6b@chromium.org>
         <46d15120-6e19-e224-47f3-e0dcbf0aeda5@soulik.info>
         <bbb6660439bb66bd9d81bb8031d9062d3c03fdf0.camel@ndufresne.ca>
         <CAAFQd5Dn97Q-tSUvT5HncV0GTQQYrBYjF-1vsmB6VPv=zrkRkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 28 juillet 2023 =C3=A0 16:22 +0900, Tomasz Figa a =C3=A9crit=C2=
=A0:
> > For MPLANE, where backward compatibility was built into libv4l2 LD_PREL=
OAD
> > wrapper,
>=20
> Could you refresh my memory on what kind of backwards compatibility we
> had in libv4l2? Was that to make it possible to use new MPLANE-only
> drivers with old applications?

https://git.linuxtv.org/v4l-utils.git/tree/lib/libv4l-mplane

It does some "magic" trick due to some of the new fields not guarantied to =
be
zero, translate the type, the capabilities. Strangely it does not filter th=
e
pixel formats. I suspect it assumes legacy application won't know about the=
 new
one and will just ignore/not use them.

Nicolas

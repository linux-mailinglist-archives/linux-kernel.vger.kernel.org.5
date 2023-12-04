Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35ED8041A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbjLDWVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjLDWVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:21:22 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1269C19B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 14:21:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1d0a7b72203so12507985ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 14:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701728465; x=1702333265; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ehtQUXwRDZKnRhPirJrr51oPYToKsRQq0IW02tneMYk=;
        b=CHiBSIMt7cCtjE0xahD6goP/Gv2seDpXWIKksbEDlzNJeAQCuE1BBt6O85BOvlICpU
         vfrZeMw6uynrOsRr1LdVB7XQd7EjPP7hw0A+NGdDKOTqPjRjcibLluM/rfLl4iNoFcV5
         r2rspn6wt0bzeTU1qwfxfnF8bWzbBo9lbzw3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701728465; x=1702333265;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehtQUXwRDZKnRhPirJrr51oPYToKsRQq0IW02tneMYk=;
        b=qMDYPQi6ovdIOj7CSirh6Q4sQnIBdrUm67YGqJFjy3JEzdTgBV+90Tp0DyiEVnwqSu
         M3SAWbj3TZ9PQJuyi9qaAXNVYcGCwERLWH4faWj7ZHS9YUcd43sYqBzHI36sPVB5hUFD
         YlY1UHCYTZVT2GDGDn3nM8C9zzL/D9qnhT/OJGI+UqfJKRu5AtvQ/WAKnlpRolmyhnM6
         PhoprJ1wZL7X2QL3VkAg/MzhohZ4DnsKAOkl4hcHrqST2SANFY3Zx3+fiav7ZIj71UjV
         yt97WfRf2bVuegrm1oJ3ilwvLCsHkI67eEsr7YoJ+tRcuOgZN0tU2S/I5Ur8vXoO+vCn
         bBGw==
X-Gm-Message-State: AOJu0YzOGLlyG682ex/jHM4bpEopiEZ2In4PKWHZlaeYkI1LsR9g0fyF
        fI6p7EZg1IuogNSNGCI6/fQtqA==
X-Google-Smtp-Source: AGHT+IEClAA5AROgHOJAOd4Gtv6KL71/ZWQlR+Vg9YJXC8KdewByNC/42QtAGDPVsAEKARgH/jvh5w==
X-Received: by 2002:a17:902:f544:b0:1cf:c649:529c with SMTP id h4-20020a170902f54400b001cfc649529cmr6001552plf.18.1701728465486;
        Mon, 04 Dec 2023 14:21:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902c44300b001d084f4fad5sm3707362plm.2.2023.12.04.14.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 14:21:04 -0800 (PST)
Date:   Mon, 4 Dec 2023 14:21:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] netlink: Return unsigned value for nla_len()
Message-ID: <202312041420.886C9F3@keescook>
References: <20231202202539.it.704-kees@kernel.org>
 <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95924d9e-b373-40fd-993c-25b0bae55e61@6wind.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:22:25AM +0100, Nicolas Dichtel wrote:
> Le 02/12/2023 à 21:25, Kees Cook a écrit :
> > The return value from nla_len() is never expected to be negative, and can
> > never be more than struct nlattr::nla_len (a u16). Adjust the prototype
> > on the function. This will let GCC's value range optimization passes
> > know that the return can never be negative, and can never be larger than
> > u16. As recently discussed[1], this silences the following warning in
> > GCC 12+:
> > 
> > net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
> > net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
> > 12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 12893 |                        flex_array_size(cqm_config, rssi_thresholds,
> >       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 12894 |                                        n_thresholds));
> >       |                                        ~~~~~~~~~~~~~~
> > 
> > A future change would be to clamp the subtraction to make sure it never
> > wraps around if nla_len is somehow less than NLA_HDRLEN, which would
> > have the additional benefit of being defensive in the face of nlattr
> > corruption or logic errors.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Eric Dumazet <edumazet@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
> > Cc: Michael Walle <mwalle@kernel.org>
> > Cc: Max Schulze <max.schulze@online.de>
> > Cc: netdev@vger.kernel.org
> > Cc: linux-wireless@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  v2:
> >  - do not clamp return value (kuba)
> >  - adjust NLA_HDRLEN to be u16 also
> >  v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
> > ---
> >  include/net/netlink.h        | 2 +-
> >  include/uapi/linux/netlink.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/net/netlink.h b/include/net/netlink.h
> > index 83bdf787aeee..7678a596a86b 100644
> > --- a/include/net/netlink.h
> > +++ b/include/net/netlink.h
> > @@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
> >   * nla_len - length of payload
> >   * @nla: netlink attribute
> >   */
> > -static inline int nla_len(const struct nlattr *nla)
> > +static inline u16 nla_len(const struct nlattr *nla)
> >  {
> >  	return nla->nla_len - NLA_HDRLEN;
> >  }
> > diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> > index f87aaf28a649..270feed9fd63 100644
> > --- a/include/uapi/linux/netlink.h
> > +++ b/include/uapi/linux/netlink.h
> > @@ -247,7 +247,7 @@ struct nlattr {
> >  
> >  #define NLA_ALIGNTO		4
> >  #define NLA_ALIGN(len)		(((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
> > -#define NLA_HDRLEN		((int) NLA_ALIGN(sizeof(struct nlattr)))
> > +#define NLA_HDRLEN		((__u16) NLA_ALIGN(sizeof(struct nlattr)))
> I wonder if this may break the compilation of some userspace tools with errors
> like comparing signed and unsigned values.

Should I drop this part, then?

-- 
Kees Cook

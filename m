Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F18E75E0B3
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjGWJW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGWJWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0E1A1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690104131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wjrc6TOLXArF64jzw4lnU3nwlr/kM5lUILDmXAhT2bQ=;
        b=cNshD94aBNgb7fwqyWxEkVBSoOVv+iyL6lZND8iG5YtwTiMUS0sFs1vz4UtHtvcSy4/x1B
        3XO+0dschz4YywaNwvRZcN5CIJCiUWnaCanu4SrDBY5afGFQXJIg3n3s6kD/mmDOFmtYcI
        71uKKWaTqPcBoBquwmmLCsjhgHpUcXk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-RTVfmwHxPNuqqCHJ1pdbBQ-1; Sun, 23 Jul 2023 05:22:09 -0400
X-MC-Unique: RTVfmwHxPNuqqCHJ1pdbBQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e3ee8a42eso1702704f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690104128; x=1690708928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wjrc6TOLXArF64jzw4lnU3nwlr/kM5lUILDmXAhT2bQ=;
        b=GlUhQ8MuEEGkiPu2kaxO5biB93F4VzicopC2jLbeVLhh6/q4w+/SXf6YzbPzYg7pCF
         g74g3IxEkMSTIDY159VuejdaekSRdPRayQ+FhKKbx3PMYp5Bz4K6LMLKwPZziHQwYEQe
         lKyjHakQbqccqmEjKmUg1/+FOz/0Rfea8svzetFLk3uDHO1JZhkXYphQkc7PqwAF+cSQ
         b1jDrNZbzXUO9cphl4bzptRw18FnWcSEhfu5niX05ATTnvNbdxOGEKQShk7wOaNZXILK
         PbNNCgCN5XzKu6lskjhOEa+iDMHKAIKBQpaH5+gUi3oUIkmXqlGduZdV/jfHDgcdp0RR
         lY4Q==
X-Gm-Message-State: ABy/qLYANmtMYvp5DHORsNDdHqAME5gXIMts8P2UrF7dak3s4Wi9eUki
        gCliqmh03UbNuusyZpebw1H/ru42bFQl2WIpBIbRNIrZ6kbcglbwKTomSdFxCxdDdIB0zm+v4Yp
        bMQi/jAau8QCdhuL0Rglq9sCMkLC6scJYC3I=
X-Received: by 2002:a5d:50c6:0:b0:317:5b5f:3348 with SMTP id f6-20020a5d50c6000000b003175b5f3348mr703716wrt.71.1690104128225;
        Sun, 23 Jul 2023 02:22:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4VWdAF8sEgmxCXAx+NL/2ya4luKKVI/QrBQmHRwPdNIMT0zNeOjBSDEEZ20I/Pl78wcJHbA==
X-Received: by 2002:a5d:50c6:0:b0:317:5b5f:3348 with SMTP id f6-20020a5d50c6000000b003175b5f3348mr703703wrt.71.1690104127892;
        Sun, 23 Jul 2023 02:22:07 -0700 (PDT)
Received: from redhat.com ([2.55.164.187])
        by smtp.gmail.com with ESMTPSA id q9-20020adfcd89000000b0030ae3a6be4asm9209312wrj.72.2023.07.23.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 02:22:06 -0700 (PDT)
Date:   Sun, 23 Jul 2023 05:22:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Lin Ma <linma@zju.edu.cn>
Cc:     jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Message-ID: <20230723050656-mutt-send-email-mst@kernel.org>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723080507.3716924-1-linma@zju.edu.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 04:05:07PM +0800, Lin Ma wrote:
> The vdpa_nl_policy structure is used to validate the nlattr when parsing
> the incoming nlmsg. It will ensure the attribute being described produces
> a valid nlattr pointer in info->attrs before entering into each handler
> in vdpa_nl_ops.
> 
> That is to say, the missing part in vdpa_nl_policy may lead to illegal
> nlattr after parsing, which could lead to OOB read just like CVE-2023-3773.

Hmm.

https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-3773

** RESERVED ** This candidate has been reserved by an organization or individual that will use it when announcing a new security problem. When the candidate has been publicized, the details for this candidate will be provided.



> This patch adds three missing nla_policy to avoid such bugs.
> 
> Fixes: 90fea5a800c3 ("vdpa: device feature provisioning")
> Fixes: 13b00b135665 ("vdpa: Add support for querying vendor statistics")
> Fixes: ad69dd0bf26b ("vdpa: Introduce query of device config layout")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

I don't know how OOB triggers but this duplication is problematic I
think: we are likely to forget again in the future.  Isn't there a way
to block everything that is not listed?


> ---
>  drivers/vdpa/vdpa.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 965e32529eb8..f2f654fd84e5 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -1247,8 +1247,11 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>  	[VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
>  	[VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> +	[VDPA_ATTR_DEV_NET_CFG_MAX_VQP] = { .type = NLA_U16 },
>  	/* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>  	[VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +	[VDPA_ATTR_DEV_QUEUE_INDEX] = { .type = NLA_U32 },
> +	[VDPA_ATTR_DEV_FEATURES] = { .type = NLA_U64 },
>  };
>  
>  static const struct genl_ops vdpa_nl_ops[] = {
> -- 
> 2.17.1


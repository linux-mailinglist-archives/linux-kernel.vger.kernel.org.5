Return-Path: <linux-kernel+bounces-155226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E05E8AE71D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF7A2869FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8BC131734;
	Tue, 23 Apr 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Sf3bP6RE"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771DA7E765
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877032; cv=none; b=oysp7WwidWAg29XCWSEDVWzm8AF83oaEjB8vXDVRARtTaqkveGDdxZu6xQEQQquhtDsJcohj1gtYqOVlbQM+Ju1uN0cKtraOL4DrQu8qRkIl949/j6XLEpecQ/OpuuoCLNTpDyxxvbUVhOQQOIuRrATxMb22XYtbSrkmsLA7MIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877032; c=relaxed/simple;
	bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nacAIIdXKfXCJsIWNgsfL5ZAXcORbI9yk4Ht1oRsf8awaRZTCf4gXUJBxxMMUoyfZC3KJAuIq6OoJY/QYIAjoQEAOvNcZjMPx6yhwvZ5HqXQAAlYCqZ4CxxGYZN/8If3TJqRwdWGjYaPR47x1T8oseL03+iZmJoU7snkG3sKdeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Sf3bP6RE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a524ecaf215so572327366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877028; x=1714481828; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
        b=Sf3bP6REppNWDKaDqKfi8e2YqJpXSW+JNoQSU7qKOvQlLQlv/il4N3iQg4bxjmdH5r
         bprzyfWaKrSVyzHvYEPTIA9BafCusyNFsbRdqUFMdJYQDjFfRrSggzD3baIYAHnWzisx
         eMAOQXfH7LGWdPrlPnq1yET6I9ct5/RoUgJDx43Q1lgZbAVSS/15pK7SFGuqGOzWPKwS
         h0FBMHl0q9vUat8SYdEwDQwS3xGJKSlPubYM6JqHV2yXII3IYP7zKitPq0f/cs3glQLl
         xAOobh/1vOUnsIt3gO28nOBINyC6d6FENYyXMHqW+cZCwZdDSGbJgejfU9uTjDzG7F/o
         qfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877028; x=1714481828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUurDejuMjUJXWGNZQxebTTMMzMT/lUL4d2VFaUQlr8=;
        b=WPzas4j2LDsMhnId3TSsQtLmCIGLuYrCl9g+PqFg1VbjoV78KwbTkr9crScWPUdsjH
         pSe4+lvVCzqNPy0DWiHvwTFqVwHDtVO4JvxNmzoWQfaImR/s4Zm0jstOgsUS+DD3PSAd
         RTX1Y73e6KnN8KINoT1PaOgNI5oVFTsOuPAngCsnT9UTOHc9PTbPeuklsk3BFhQv/uM1
         AtJli9eQ0JfZyDnBSWG4pjd1tObcGHtcV3zq1ruv319T4OIgS3oIoFP0+tbeswxROxlp
         T201ZtblkcY1iVu0MdPm7L4gj481ETA8XElQAUCvSP6hPN3Q9SJlCf32ANWEfwlull8u
         O46g==
X-Forwarded-Encrypted: i=1; AJvYcCXz1wM7Ckl5Xg9TeyG+bNurr1xgCI3Oowj+R/a35USFBdMc+gdIV9YC0exWdzJ/FSlAzOJ/fzvbp3AsqXiH+hpc6YjrD7uypf07d31E
X-Gm-Message-State: AOJu0Yzf6iDUwLFmOVyo2ieyNf9QQk47peYAHhmtRxmjQbkdFWlz4e1o
	jGVpCp/9Fp/WFsEggZ+nDkZxP4Vc/OuSkCH4g4Rv6tR7YdZncKBR8ujMQGCQ7bw=
X-Google-Smtp-Source: AGHT+IGK1ELuEtclHLgCVabv5MmGFAEEubLdqqJGCuRlvQs/jGoQmRSFLWi6waZWFO9QB7Mlx2Y9hA==
X-Received: by 2002:a17:906:2b14:b0:a57:5ef3:9a16 with SMTP id a20-20020a1709062b1400b00a575ef39a16mr2633205ejg.13.1713877027473;
        Tue, 23 Apr 2024 05:57:07 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id jw24-20020a170906e95800b00a5880f8c84csm633006ejb.36.2024.04.23.05.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:57:07 -0700 (PDT)
Date: Tue, 23 Apr 2024 14:57:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH net-next] net: ethernet: ti: am65-cpsw: flower: validate
 control flags
Message-ID: <ZiewIaho9AwDu3g6@nanopsycho>
References: <20240422152643.175592-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240422152643.175592-1-ast@fiberby.net>

Mon, Apr 22, 2024 at 05:26:42PM CEST, ast@fiberby.net wrote:
>This driver currently doesn't support any control flags.
>
>Use flow_rule_match_has_control_flags() to check for control flags,
>such as can be set through `tc flower ... ip_flags frag`.
>
>In case any control flags are masked, flow_rule_match_has_control_flags()
>sets a NL extended error message, and we return -EOPNOTSUPP.
>
>Only compile-tested.
>
>Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>


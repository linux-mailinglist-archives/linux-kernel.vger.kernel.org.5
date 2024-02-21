Return-Path: <linux-kernel+bounces-75449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A166485E8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3146A1F2445F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B92126F0F;
	Wed, 21 Feb 2024 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H7gtXKyz"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4B8613C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708546215; cv=none; b=PydM5o2RHbYP/QkJ38ENmG181j5BDm/7QbEzCUjIkO32IzbnU1MStbki2KDmt7y4pN1dVIxh60butdWdUi/d5opgYFjeHNu+quPViWL44YRYs0WVIHstQXbfKu6kaukx+bZeAD9AZnQ0JK3Tu3Dz9bY8jyKqFVbwiIv2UiU8/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708546215; c=relaxed/simple;
	bh=Gw1qFa2sTaW6NAX67zauZz8mX6m2BwqWtFKUyx8h/E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2bxSaE8ZLyK7hKjIxWJQ0nWTZd32s+hDeClkE9QpaZ9oXMH8/A+8vKA3BCgWlbG/oL300O2OqnMX9XUKZYTD6w2DwkRQJ/s25q3DfG5TYJRZMhxZ3CDdTwZgvFtrPNeWFaptqb9r41UpWtH/Zfziduo2pjRytIpkwD1f+edwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H7gtXKyz; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3651607db16so621475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708546212; x=1709151012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M5Z0SZna9UOg1Ona+bZVgLrYz4/0TkaS32NjeJUhFJg=;
        b=H7gtXKyzORbMLg++gje0TM8sJmMHkbmFW85pgzHIa9cmfwdpuBMnxSErLUjTUJtHgB
         kzwQFpRKeFS4oJ/HMGvQz9wD8SS1iF636B+E4ZTV4lU28llxmgtxCdSA+NmD16wjNmiy
         zS6OdNmTtXbySfPzus4bc5NsRf6kaw4ZRzvHxgWvLrv7WV0DL8lK6XGvKLu4f47sMB6i
         dLGsL5KscgXmByVU/406oD3Ij3/jwnS2jbIM3VD8I69pPDSBP7ZW0VWRcDtXk2AqDEsy
         o16Mom8dSmYxV4Go4G3PH7RZCU6JipQCJVWFWxjaiT2pVpqoHUTje9w0/M25RVY4jfW0
         GoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708546212; x=1709151012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5Z0SZna9UOg1Ona+bZVgLrYz4/0TkaS32NjeJUhFJg=;
        b=EGXRuVmPSl+Vf0kWhgA66nLNsmaq2ZQqY+AJVDXakJCdc8rzlfqg0wcmncaAgA+6E3
         bn+vG7kS4xHESpRuGZb29GKOXPTj4alr0zwEr7s+UwriDaryTmTd+vrltvl1XLAS0oQY
         35dsKyDcFm1ynrke2HLwTO3Q5gCdb21nm73lRgHGLBEyCjtt2KI34zjIasreTf0p/z8d
         9y+lr08R3vz8dmJYR5MobDrh+PI1Cqv+shSoW1BdtHJi+TcdVha0cPQvHCC7hXax9m8U
         avhSAxiL2kCN+UsDLJHc33t6atH3DbEjjOPwNS1T5aFSxnBRkNp1oXf5DBAJ52bzBrmk
         XNog==
X-Forwarded-Encrypted: i=1; AJvYcCXkoJpVgGanKh1vfB6ZFYBsUVkZgPb5CJmoC6dpjNsimdM0nVbYga5XKfvB6yxFcQjzDjEBMCOUGIFsAR1U8bOlG8Rfol3Sq6ONbEOh
X-Gm-Message-State: AOJu0YxcXBxIVAJUEdtubvy+8WrmS44gLCCUSr1MqW7J0dIOEMrhszbL
	7uBsDdwQNgvdq2ZZVtQafN+OngUYq3lLd1JmdKj9hGl1VR7awOmvhFH6kc5B2w==
X-Google-Smtp-Source: AGHT+IH9AMuXPl3EZJ7hQlp6VCclDdr80TZvmeM7CdT+Wyei5omqYzpG9JNSpVS4vNSKPPCjP6+45g==
X-Received: by 2002:a05:6e02:1a0e:b0:365:249c:690 with SMTP id s14-20020a056e021a0e00b00365249c0690mr505292ild.9.1708546212041;
        Wed, 21 Feb 2024 12:10:12 -0800 (PST)
Received: from google.com (161.74.123.34.bc.googleusercontent.com. [34.123.74.161])
        by smtp.gmail.com with ESMTPSA id t18-20020a028792000000b004715e8aaea2sm2842840jai.102.2024.02.21.12.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 12:10:11 -0800 (PST)
Date: Wed, 21 Feb 2024 20:10:08 +0000
From: Justin Stitt <justinstitt@google.com>
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Kees Cook <keescook@chromium.org>,
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Florian Westphal <fw@strlen.de>,
	Cassio Neri <cassio.neri@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arthur Grillo <arthur.grillo@usp.br>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Latypov <dlatypov@google.com>,
	Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/9] lib/cmdline: Fix an invalid format specifier in an
 assertion msg
Message-ID: <20240221201008.ez5tu7xvkedtln3o@google.com>
References: <20240221092728.1281499-1-davidgow@google.com>
 <20240221092728.1281499-3-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221092728.1281499-3-davidgow@google.com>

Hi,

On Wed, Feb 21, 2024 at 05:27:15PM +0800, David Gow wrote:
> The correct format specifier for p - n (both p and n are pointers) is
> %td, as the type should be ptrdiff_t.

I think %tu is better. d specifies a signed type. I don't doubt that the
warning is fixed but I think %tu represents the type semantics here.

>
> This was discovered by annotating KUnit assertion macros with gcc's
> printf specifier, but note that gcc incorrectly suggested a %d or %ld
> specifier (depending on the pointer size of the architecture being
> built).
>
> Fixes: 0ea09083116d ("lib/cmdline: Allow get_options() to take 0 to validate the input")
> Signed-off-by: David Gow <davidgow@google.com>


> ---
>  lib/cmdline_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/cmdline_kunit.c b/lib/cmdline_kunit.c
> index d4572dbc9145..705b82736be0 100644
> --- a/lib/cmdline_kunit.c
> +++ b/lib/cmdline_kunit.c
> @@ -124,7 +124,7 @@ static void cmdline_do_one_range_test(struct kunit *test, const char *in,
>  			    n, e[0], r[0]);
>
>  	p = memchr_inv(&r[1], 0, sizeof(r) - sizeof(r[0]));
> -	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %u out of bound", n, p - r);
> +	KUNIT_EXPECT_PTR_EQ_MSG(test, p, NULL, "in test %u at %td out of bound", n, p - r);
>  }
>
>  static void cmdline_test_range(struct kunit *test)
> --
> 2.44.0.rc0.258.g7320e95886-goog
>

Thanks
Justin


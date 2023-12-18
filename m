Return-Path: <linux-kernel+bounces-4172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B96C18178C4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7BB91C24A3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384D5BFA2;
	Mon, 18 Dec 2023 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g/6q6EZB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280655BF93
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c2bb872e2so39764405e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1702920598; x=1703525398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fs4PeLX+sTsxEfE9JWWvETdWRfgtXAd+hsb7EMzfzZY=;
        b=g/6q6EZB+WjHJGN2Zjf0bKdXE1QISkxRoQTx3ri6be9kLTjLJYl840Ip257xNF16J9
         rrUu3MeTZmZeVTAqpEqGVHAqkEKkTC7nl00ZEsnhwCqQhvzmK5H5OJqmvDwaWq15PUj+
         5Q1SAZQWX/V8JAU3ix4fiUCy0ucZa/+aFDOm8oRf0eQ5+oi4o5y6AtYyAbxaj593eF4+
         NHEtjMPpCvm0zpQ1x1CQ9AdQV38ULYmrJDzP6uT9pUJrOimbSQ8N+cm88ESvlpOE7oGc
         qNVVRK/tDAYIiBYxSBKvSPNMlWUM2OXBsg1uW1XlMZDTcvffkey+O1f+h0S3Omb/NXuc
         l4mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702920598; x=1703525398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs4PeLX+sTsxEfE9JWWvETdWRfgtXAd+hsb7EMzfzZY=;
        b=OjtmAmmXRH4xfaB1yYGAtGQcT2iNir9EUB6zWV0JVRMY0jd5tQaeSDkNCg2abErELd
         fcooa7QhLpkZ5oIdQ5Az1jnTDcr4zyEgmoET5ZxGKB3FO5LdJ21XUtc9uG09tEpJNncb
         0PltZHLrVYNaqsulhFdVWKtE2hf6sDzInpNqp7DqEx/Pbg3/qRWPQB75WrfJlV6RUkWp
         7d+ZFcEH1WAY8LMg7sqHoj7IKVn5JzroD0bUujTMyEstJpBkCDMzhe7YBeTyK8GPWnA4
         dDY5+3u30KMBXt5sEe4VwZLZX2T/OpOVzOprF7NJ6g9rnOFOABNK0TbPg/WU4B5pFnWU
         a81Q==
X-Gm-Message-State: AOJu0YwLHAegXnOOikYsEjVt5X8UoCL1RsVXd/qREusG6VktYHWh7Md1
	OCAgESYeTWXKdoA9m2JVgTdTQQ==
X-Google-Smtp-Source: AGHT+IFZW3zce2+UNUMbSECCaMNdkD3J4utubpXbLJ3MtTK3HEC5MqbzeHyJw5JqLSDbUXz/s9Ojsw==
X-Received: by 2002:a05:600c:22c3:b0:40c:61fe:383c with SMTP id 3-20020a05600c22c300b0040c61fe383cmr1874449wmg.198.1702920598358;
        Mon, 18 Dec 2023 09:29:58 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090611d200b00a2362ef4387sm810515eja.49.2023.12.18.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:29:58 -0800 (PST)
Date: Mon, 18 Dec 2023 18:29:56 +0100
From: Petr Mladek <pmladek@suse.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: lb@semihalf.com, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, bleung@google.com, contact@emersion.fr,
	daniel@ffwll.ch, dianders@chromium.org, groeck@google.com,
	jbaron@akamai.com, john.ogness@linutronix.de, keescook@chromium.org,
	ppaalanen@gmail.com, rostedt@goodmis.org, seanpaul@chromium.org,
	sergey.senozhatsky@gmail.com, upstream@semihalf.com,
	vincent.whitchurch@axis.com, yanivt@google.com,
	gregkh@linuxfoundation.org
Subject: Re: [re: PATCH v2 00/15 -  05/11] dyndbg: change +T:name_terminator
 to dot
Message-ID: <ZYCBlI56kmDMew6U@alley>
References: <CAK8ByeK8dGcbxfXghw6=LrhSWLmO0a4XuB8C0nsUc812aoU0Pw@mail.gmail.com>
 <cover.1701993656.git.jim.cromie@gmail.com>
 <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7cb5c8b6c6efba7e437595266638be39f23361fc.1701993656.git.jim.cromie@gmail.com>

On Thu 2023-12-07 17:15:08, Jim Cromie wrote:
> This replaces ',' with '.' as the char that ends the +T:name.
> 
> This allows a later patch to treat ',' as a space, which mostly
> eliminates the need to quote query/rules.  And this in turn avoids
> quoting hassles:
> 
>   modprobe test_dynamic_debug dyndbg=class,D2_CORE,+p
> 
> It is particularly good for passing boot-args into test-scripts.
> 
>   vng -p 4 -v \
>   -a test_dynamic_debug.dyndbg=class,D2_CORE,+p

Could you please add example how it looked before and after?
Is this format documented somewhere?
Will the documentation get updated?
Could it break existing scripts? [*]

The dynamic debug interface is really hard to use for me
as an occasional user. I always have to look into
Documentation/admin-guide/dynamic-debug-howto.rst

Anyway, there should be a good reason to change the interface.
And the exaplantion:

   "Let's use '.' instead of ',' so that we could later
    treat ',' as space"

sounds scarry. It does not explain what is the advantage at all.


[*] Some scripts are using the interface even in the mainline,
for example:

$> git grep "dynamic_debug" tools/testing/
tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ip_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ip6_gre.c +p' > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file geneve.c +p' > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/bpf/test_tunnel.sh:     echo 'file ipip.c +p' > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/livepatch/functions.sh: DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
tools/testing/selftests/livepatch/functions.sh:         echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/livepatch/functions.sh:function set_dynamic_debug() {
tools/testing/selftests/livepatch/functions.sh:        cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
tools/testing/selftests/livepatch/functions.sh: set_dynamic_debug


Best Regards,
Petr


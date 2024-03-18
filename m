Return-Path: <linux-kernel+bounces-106591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9066C87F0B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BC81C21C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2F5731C;
	Mon, 18 Mar 2024 20:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GpIwdP4p"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC3B5733F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710792051; cv=none; b=WQ0/DdgMT6rl+sUz7XS8TcTSUXD/ukSFEbDWFok6L8seJum/RIMM8teQE31hoFvUgjj/4oFNucBf9vdj3S1/RZW9RqmzMqLGcpIuJJIqY562pA5dxIga55v6fhFZiHBi9YM/gJYtMQ4n1TbDYg3YX+/Uyf3kSrjUtueJL9zPfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710792051; c=relaxed/simple;
	bh=4UU/Wt6ugiN/8OdzdCOP/dpF0PyxGrerAfISuir4TCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn9FQdqzsiAI5fIvvUZLBZnCZJLmPIfgUm1SiBC3Jstg6Nu0u4WZmhfSlEocYkgZ7ACOG/6yOxbM0Khc5yYNYwD4mUxLIp6Xe6yDkAL98KW6lnVc7apn2wKesjeFvH8BXdqgTFIxZjSIWDgQn+nOxkePbvQ3ckm1v3U9ntNTR38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GpIwdP4p; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d47a92cfefso64356281fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710792047; x=1711396847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/uOKD1vdAmoLenmLGYJq1arvP7Bn4vYf3UI4yux59c=;
        b=GpIwdP4pDae9aTfcYO2dQ1fi6AFOwngO90B7UwFcXBjn+sS/7OpOM569aRKAo5pF77
         pH0cHl6PaWoZG2oACF+pq5pe7cf++3E8U3EiAyje3c9P1zBpS0TxUQEbVSsc0u3tAwJY
         KXNHo61uMG9TmtNYEy/eiLdobaUdskFBU+AVu9HiRib1dWjz1qprubO29xoYqHIQRj6q
         sC7WEr0tBBuMMtteLCztg9qi8SE38HSZlkjOpAAvgfi3DiMRtkOV45zNGLa1YnEIfdse
         XoG3Q3aOZEY+RKH2Rk+ZEjgC7AL/ESLIooaSGoSX99kWcWLl4DxbwojB77jrRZNh36hH
         vHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710792047; x=1711396847;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/uOKD1vdAmoLenmLGYJq1arvP7Bn4vYf3UI4yux59c=;
        b=cSn2mb96KSRAKHQycsnhd1CucV/6pW9xPc/vzXHjAhbNbLrj/Vn6udCAlQ1aJiqWXb
         Qn4v5qFje2MWh5Re8nCjSO+hPKTuE6MN/AwgFJnhdwVCSUdMAq++lqtQJ0Da0RuVHHOl
         49zR81RQQqVI/Po61AlHIxsH33afsB0+UBr7ZYluvko9uCE9y1G4KuHHTj7HuN5rPO52
         sIlMTubLw8RpSb132N2oypWn8VVXjBV3JJeprQyH5b/8EvA15gFoY4vze1ql8ebiM2yJ
         zUYMPEL4PIULsVMtlJ0RMUPGnkGzPcC/D+5QVElJ8ciMEl6hSUmLUOg8roKjUEJ1/yrL
         PhZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpYcdKbU5kC/XgA2o9ftSTB23izrPVHoFnYvndHkAuDgnOwOGClr4NN1T1sobSwmOlUZ7ct8BFgaNBiuWFe9ouedz6O4O6FTpnFS3X
X-Gm-Message-State: AOJu0YzKvv8Tieoa/jRq4yV8xqEgklzO7P50mTeY0IW6+e0pNgMxta4O
	sCvQZwHpaaqyOw6wHSVyCY49H5mQJvy6wLh2QU2ZMGBy5NTiHqH0AP6AmnK7qkg=
X-Google-Smtp-Source: AGHT+IGn0cDzWBnnZPzwWaYjEKj1pD1PrLo79AiavzmxTMEEIb617V/diJW81rlnhNqkOQMDnrvRLw==
X-Received: by 2002:a2e:9001:0:b0:2d4:7455:89f4 with SMTP id h1-20020a2e9001000000b002d4745589f4mr7487623ljg.2.1710792047553;
        Mon, 18 Mar 2024 13:00:47 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001db37fd26bcsm3595673plf.116.2024.03.18.13.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 13:00:46 -0700 (PDT)
Message-ID: <ea4ebb71-df6d-40e1-9e37-a0131b23d63d@suse.com>
Date: Tue, 19 Mar 2024 06:30:41 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: New helper to clear EXTENT_BUFFER_READING
Content-Language: en-US
To: Tavian Barnes <tavianator@tavianator.com>, linux-btrfs@vger.kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-kernel@vger.kernel.org
References: <cover.1710769876.git.tavianator@tavianator.com>
 <477327c2e21e253b56261f504a91603419bb167a.1710769876.git.tavianator@tavianator.com>
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <477327c2e21e253b56261f504a91603419bb167a.1710769876.git.tavianator@tavianator.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/19 00:26, Tavian Barnes 写道:
> We are clearing the bit and waking up any waiters in two different
> places.  Factor that code out into a static helper function.
> 
> Signed-off-by: Tavian Barnes <tavianator@tavianator.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/extent_io.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 61594eaf1f89..46173dcfde4f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -4270,6 +4270,13 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
>   	}
>   }
>   
> +static void clear_extent_buffer_reading(struct extent_buffer *eb)
> +{
> +	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> +	smp_mb__after_atomic();
> +	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
> +}
> +
>   static void end_bbio_meta_read(struct btrfs_bio *bbio)
>   {
>   	struct extent_buffer *eb = bbio->private;
> @@ -4304,9 +4311,7 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
>   		bio_offset += len;
>   	}
>   
> -	clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> -	smp_mb__after_atomic();
> -	wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
> +	clear_extent_buffer_reading(eb);
>   	free_extent_buffer(eb);
>   
>   	bio_put(&bbio->bio);
> @@ -4340,9 +4345,7 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num,
>   	 * will now be set, and we shouldn't read it in again.
>   	 */
>   	if (unlikely(test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))) {
> -		clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> -		smp_mb__after_atomic();
> -		wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
> +		clear_extent_buffer_reading(eb);
>   		return 0;
>   	}
>   


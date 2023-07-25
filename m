Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE0760CB1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjGYIL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGYILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:11:23 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500A1A4;
        Tue, 25 Jul 2023 01:11:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690272680; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p8aK7Ur6DA8oeqiGfr0gF82e7b77Q3nsHhjFKm2krehWyZ4Y6jqga6udVu4iCQKhSf
    HHUyGV5tF/uRoNCzvjfL9Tcbx1PzUztSf6/mgGdbUZpfjGdfYbqyYVlolyY+kwM82Uub
    Q1fyB7xQKb0R5HGC/NTuZydJxb3iJk44KwF0o4ZivnbGo9cAJa7rj66SsUnqPUHEamB3
    dx1eBd5yeD7dhUzBkXNb6HBSjAO1JzFBTO0TaAHdKTF7h1N/+v/OpgZCtCdbo3IiaUJ2
    OTJW0+O2uh5vTaP74J3bx0G75dhOb5fzvWYenCgeKi0dvyMOhFRSZzelZMqAJbDJHE9M
    C0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690272680;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=58lEMKdRV0lL3TdLnEe2CjRI3cp0N+47G6Y5ZfvF3Fc=;
    b=bkKbXo5QoWXHSxYSJ/E/iyusV7yNj/b0w9jsgUPOB2VnmNSvy5yQ1rZNhzIVFBx6vd
    2D08PAs4ls+xYCPfrJMsjy1WjFC8x5OxmCDw1z8D6KY8CX/pnz73FQWp2wf/Xq7QahMZ
    abaE25my0f13cMB3tTPj+QEc41mNUIG5wiiyT0s58XppaDlEWw3Jy9IUbHH7X3iIwccQ
    Xhz44+EMgZIip6FicMcdQ9FleK1gUD786wXX9j80RAcSRlzW0YWGbqFcscNqEmRfwHhS
    4pz1DMAdolPwgUDl1DjNjOExXeY9U5qBpWYhr6/tHqv4EZHY5eJjJEJuOhvhnpC29p9k
    LIkg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690272680;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=58lEMKdRV0lL3TdLnEe2CjRI3cp0N+47G6Y5ZfvF3Fc=;
    b=YtwwLokbfE3KuYu1qodtgXXn7/t/ZBsLcKm4TdX0A42OT3Dum3ChoOQfG5WGN7lfgO
    C/d5HW4CD0qBqCCnV1S52sxbSGNN7nzdvk6GPVFgR05yb7Z2u5kFO9FxYhKcc7fcndqD
    AdlihdDHMELCiXwNQgBh/bNjYUyn7ypsme4tj+Vlo0BYzySRo0w0huckIpFzW9h2Mmf3
    RFvd0oFSbg2MSD2OSxcU8jyCXpAMV6wMwElB8GWIqBVWAK2t05Om53Ti6MnNoHEkQkrP
    w9ZYWaYdYAkH5lO7s2bTTsRyOadpC6d5D8IcFclVn2A81vZbiEArMJViWFjnmDnaD66i
    XC5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690272680;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=58lEMKdRV0lL3TdLnEe2CjRI3cp0N+47G6Y5ZfvF3Fc=;
    b=L6GjOzIjncNWqUCj9etts7LZfa02F9qNT2yIkQCd/smZPW5ID5JauMzHmcrcPHLQBb
    IEB4EmyPSbeggTVNJNBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6P8BK25M
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 25 Jul 2023 10:11:20 +0200 (CEST)
Date:   Tue, 25 Jul 2023 10:11:14 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: msm8939-longcheer-l9100: Add
 initial device tree
Message-ID: <ZL-Doh6a9rqQPGVe@gerhold.net>
References: <20230724-bq_m5-v1-0-17a0870a73be@apitzsch.eu>
 <20230724-bq_m5-v1-2-17a0870a73be@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724-bq_m5-v1-2-17a0870a73be@apitzsch.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 10:52:42PM +0200, André Apitzsch wrote:
> This dts adds support for BQ Aquaris M5 (Longcheer L9100) released in
> 2015.
> 
> Add a device tree with initial support for:
> 
> - GPIO keys
> - Hall sensor
> - SDHCI
> - WCNSS (BT/WIFI)
> - Accelerometer/Magnetometer
> - Vibrator
> - Touchscreen
> - Front flash
> 
> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  arch/arm64/boot/dts/qcom/Makefile                  |   1 +
>  .../boot/dts/qcom/msm8939-longcheer-l9100.dts      | 340 +++++++++++++++++++++
>  2 files changed, 341 insertions(+)
> 
> [...]
> diff --git a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
> new file mode 100644
> index 000000000000..74782e323a2c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
> @@ -0,0 +1,340 @@
> [...]
> +
> +	usb_id: usb-id {
> +		compatible = "linux,extcon-usb-gpio";
> +		id-gpio = <&tlmm 110 GPIO_ACTIVE_HIGH>;

id-gpios, to avoid conflict with
https://lore.kernel.org/linux-arm-msm/20230724103914.1779027-7-alexander.stein@ew.tq-group.com/

> +		pinctrl-0 = <&usb_id_default &usb_id_switch_default>;
> +		pinctrl-names = "default";
> +	};
> +
> +};
> [...]
> +
> +&mdss {
> +	status = "okay";
> +};
> +

I'd introduce this together with the display support.

Thanks,
Stephan

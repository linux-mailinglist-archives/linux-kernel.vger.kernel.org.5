Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF69789B84
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 07:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjH0Fyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 01:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjH0FyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 01:54:07 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE6A121;
        Sat, 26 Aug 2023 22:53:57 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.97.125]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUokB-1q9uju3HLV-00QnIT; Sun, 27 Aug 2023 07:52:55 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id B485D3E71A; Sun, 27 Aug 2023 07:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1693115573; bh=PEBDu2LsYY9cfkceNFyC5Y0UToOR2TEeQSWUUb4j1EY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JCf0AfwHTDyJG1qgVCiprdeiykbLHvErIpo0x7UTB/0gmVSCUg1uzVwkcrUDGHUoQ
         72PMany4IEdzQXz86FVIak/eHwGo/UMjsszLFXnZ2MuPBlYFOkpK8JmZsu3A++zAXw
         oXXdPN13opbRFW2Z0qoA7PjqiUxkog34/G114yB4=
Date:   Sun, 27 Aug 2023 07:52:53 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, u.kleine-koenig@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] scripts: Add add-maintainer.py
Message-ID: <ZOrktcX1L6WHmLBi@fjasle.eu>
References: <cover.1691049436.git.quic_gurus@quicinc.com>
 <829b08342568735095bbd3f8c44f435f44688018.1691049436.git.quic_gurus@quicinc.com>
 <ZOYicEP8D7kNGFin@fjasle.eu>
 <20230824214436.GA22659@quicinc.com>
 <ZOiUOcMOeYvMzq58@bergen.fjasle.eu>
 <20230825170001.GB22659@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825170001.GB22659@quicinc.com>
X-Provags-ID: V03:K1:SHb9/Jr2C2NWaPBXsZy0Asb6ySKk1dxrD8lEMkQnI7Yz5bn3Bws
 wL9hkEZV66e+uhHiooIZXq4Tnyy/vy+IIljkiMhA5PM8a+heCD9cEm2wwwDbZiUCN6idND/
 csJbRciSBbi9Qgh7tTo3VJTx1yNtNI7UUnZvNM+zLKXo68/Ry78e2VSL9D4lDWIw4Zj/ich
 ZmHumxiXlyy67Rxf8Mywg==
UI-OutboundReport: notjunk:1;M01:P0:pb8TgKev4sc=;b+LNStGfk+7SG1dylUYX4fWyXEd
 GbmjoydExqsKwip/t1r6MtoRY7AnqFmu9TNDE/nUN/xJLzo1tV6euglY0ZfYbSb4kOFwoFHKh
 IDOzWdcS9oYgfz5GqC3owEfMVj92Qj+/iFcMSGiJh46P+zl/sXpLbEsFlQ2YNdEJG5hgHX384
 43YHVrB//kpPGKhvJsDlLD7UxfbGR+Wi69Fothe6it4KdUSDpS5Uh5GfIk89QIBW6M0RrzhNh
 vi7d+OXCMIIMzabHWWfKJFGqKN5cvqp3nSlgivMCP5nWHu03gD6jKzdgRSN/Y15bi4NuSy5HQ
 12D2C1g5kBem/A8k/F8QYO3qMFlX2lGZycBftGe6pp4Go0YOS7dXDHUW+Rym9iesU5zlwqdQQ
 Gtk9sKmtvNV69WoQRHmCrdHyVWdE040og8Hjr/TnSRvUY6Y3l93+uhgdj96IkQwsZ2IHp2aJ+
 I6OJ1azevh+sppDxhvsGTpXIUBa3zKDzdb8WVg1EPqqTNo5ul0Yr04diXMXYI9o6syaLbJ+9B
 d4AUpB1oZvl/nboFTAPdo0iwyqkkfpKoqnh3ETd5yJC+aQE8Jg+S6j7AEmhSu8+jToES3jfUk
 iGlRAETOWyIwzqRVj00WpFNnGvfVqb9Al4asIRwXrr8KbbtzQYV/+hrLrYTZmSkdeeU9jzMLP
 Rs5HpSKn2c+9/dDb3W7u0mhLx6Ot0WFGmE4ERf6T4fmWGxaBB8UgNW1ysdSdn8lQcFt2wKHQx
 UG9j0htsw9TCJqfGXcbT9Z44xbUAVcmp6XtQMGSwQueKN83/wCNM7tFl0Syhdr8IrYfcs7JB6
 wRGeDNWUnsokLK7BdKfPWQq9eQ0djKw56yR+HenDPiBMbGRh4vnqmdE8AQ+//gSKOCbJ+wb9d
 r9dwLWIR7CxYN4g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 10:00:01AM -0700 Guru Das Srinagesh wrote:
> On Aug 25 2023 13:44, Nicolas Schier wrote:
> > On Thu 24 Aug 2023 14:44:36 GMT, Guru Das Srinagesh wrote:
> > > > While testing, I thought that adding addresses without filtering-out duplicates
> > > > was odd; but as git-send-email does the unique filtering, it doesn't matter.
> > > 
> > > Since I'm using `set()` in this script, the uniqueness is guaranteed here as
> > > well - there won't be any duplicates.
> > 
> > I thought about patch files that already have 'To/Cc' headers (e.g.  
> > 'git format-patch --to=... --cc=...' or by running add-maintainer.py 
> > multiple times for updating the lists of recipients.  The result is a 
> > patch file with possible duplicated lines; but as written: it does 
> > matter, effectively.
> 
> Sorry, did you mean "does" or "does *not*"?

I'm sorry, "it doe not matter".

Nicolas

> I'll make sure to test v3 of this script out on patches that have To/Cc already
> included and also run it multiple times on the same patch (effectively the same
> thing).
> 
> Thank you.
> 
> Guru Das.

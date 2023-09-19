Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94127A6839
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjISPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjISPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:38:06 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED919D;
        Tue, 19 Sep 2023 08:37:58 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38JCag9K031104;
        Tue, 19 Sep 2023 17:37:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=lmqqn/XcXA51CdrMLduyXuE2aPpcmaz2mdk58r7MlEo=; b=wS
        H7Y93bNnykPjn8+ET4WIxSZrYi0isRNcEDx2EjL/5NUq2mhBZ1GUVQE2IHnjZBjQ
        qhZu88i762XbNBcHBF4zIUfGCOdFpHiP+q7k/iqSIQEidswJpqFmI91i5hDEjyrZ
        CZNRMyE3OAaaT1eK3UubocHkCQdgtcR/BQKhVHuhg82C6B/CLifcU9CiPOVgXPwe
        su2iCdbLKBctS7AOqArR8fzud6lQDqC3Xck4UpsgnF+YQqJjxikYePvwUUe/JC85
        +oQyC5o+RhHKP8lpSXDECkAlNfhtjUzv6fXAa8xF8bWCj8ZFNo8mZr5CJBxe+iNk
        moBP9LmnCUoxn+eM8ytg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t51sfbmsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Sep 2023 17:37:37 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id CB0B4100064;
        Tue, 19 Sep 2023 17:37:35 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B1DA42629DB;
        Tue, 19 Sep 2023 17:37:35 +0200 (CEST)
Received: from [10.252.3.245] (10.252.3.245) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 17:37:35 +0200
Message-ID: <7aa66ac8-eceb-2f6e-960b-2c4dac9f595e@foss.st.com>
Date:   Tue, 19 Sep 2023 17:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/8] tools/counter: add a flexible watch events tool
Content-Language: en-US
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     <lee@kernel.org>, <alexandre.torgue@foss.st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-4-fabrice.gasnier@foss.st.com>
 <ZQdOcDQR6qONmmnR@fedora>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <ZQdOcDQR6qONmmnR@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.3.245]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_06,2023-09-19_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 21:07, William Breathitt Gray wrote:
> On Tue, Aug 29, 2023 at 03:40:24PM +0200, Fabrice Gasnier wrote:
>> This adds a new counter tool to be able to test various watch events.
>> A flexible watch array can be populated from command line, each field
>> may be tuned with a dedicated command line argument.
>> Each argument can be repeated several times: each time it gets repeated,
>> a corresponding new watch element is allocated.
>>
>> It also comes with a simple default watch (to monitor overflows), used
>> when no watch parameters are provided.
>>
>> The print_usage() routine proposes another example, from the command line,
>> which generates a 2 elements watch array, to monitor:
>> - overflow events
>> - capture events, on channel 3, that reads read captured data by
>>   specifying the component id (capture3_component_id being 7 here).
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> Hi Fabrice,
> 
> This is great idea, it'll make it so much easier to test out drivers
> so I'm excited! :-)

Hi William,

Thanks

> 
> This is a new tool, so would you add a MAINTAINERS entry for the
> counter_watch_events.c file?

I haven't thought about it.
I can add a MAINTAINERS entry, yes!
Who would you suggest ?

> 
> More comments inline below.
> 
>> ---
>>  tools/counter/Build                  |   1 +
>>  tools/counter/Makefile               |   8 +-
>>  tools/counter/counter_watch_events.c | 348 +++++++++++++++++++++++++++
>>  3 files changed, 356 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/counter/counter_watch_events.c
>>
>> diff --git a/tools/counter/Build b/tools/counter/Build
>> index 33f4a51d715e..4bbadb7ec93a 100644
>> --- a/tools/counter/Build
>> +++ b/tools/counter/Build
>> @@ -1 +1,2 @@
>>  counter_example-y += counter_example.o
>> +counter_watch_events-y += counter_watch_events.o
>> diff --git a/tools/counter/Makefile b/tools/counter/Makefile
>> index b2c2946f44c9..00e211edd768 100644
>> --- a/tools/counter/Makefile
>> +++ b/tools/counter/Makefile
>> @@ -14,7 +14,7 @@ MAKEFLAGS += -r
>>  
>>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>>  
>> -ALL_TARGETS := counter_example
>> +ALL_TARGETS := counter_example counter_watch_events
>>  ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
>>  
>>  all: $(ALL_PROGRAMS)
>> @@ -31,6 +31,12 @@ $(OUTPUT)include/linux/counter.h: ../../include/uapi/linux/counter.h
>>  
>>  prepare: $(OUTPUT)include/linux/counter.h
>>  
>> +COUNTER_WATCH_EVENTS := $(OUTPUT)counter_watch_events.o
>> +$(COUNTER_WATCH_EVENTS): prepare FORCE
>> +	$(Q)$(MAKE) $(build)=counter_watch_events
>> +$(OUTPUT)counter_watch_events: $(COUNTER_WATCH_EVENTS)
>> +	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
>> +
> 
> Move this below the COUNTER_EXAMPLE block just so we can keep the
> recipes in alphabetical order.

Ack, will update it.

> 
>>  COUNTER_EXAMPLE := $(OUTPUT)counter_example.o
>>  $(COUNTER_EXAMPLE): prepare FORCE
>>  	$(Q)$(MAKE) $(build)=counter_example
>> diff --git a/tools/counter/counter_watch_events.c b/tools/counter/counter_watch_events.c
>> new file mode 100644
>> index 000000000000..7f73a1519d8e
>> --- /dev/null
>> +++ b/tools/counter/counter_watch_events.c
>> @@ -0,0 +1,348 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Counter - Test various watch events in a userspace application
> 
> "Counter" should be "Counter Watch Events" (or "counter_watch_events").
> 
>> + * inspired by counter_example.c
> 
> No need to mention counter_example.c, this utility does far more than
> and bares little resemblance at this point to counter_example.c which is
> really just a bare minimal example of watching Counter events.

Ack

> 
>> + */
>> +
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <getopt.h>
>> +#include <linux/counter.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <sys/ioctl.h>
>> +#include <unistd.h>
>> +
>> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> 
> My initial reaction was that this macro is already exposed in some
> header for us, but my local /usr/include/linux/kernel.h file doesn't
> appear to bare it so I guess not. Perhaps it'll be fine for our needs --
> I think the only difference between this ARRAY_SIZE and the Linux kernel
> one is the addition of __must_be_array(x).

I had the same reaction when trying to use it. Then, I figured out
several tools redefine this macro.
Digging further, I just found out some tools have in their Makefile CFLAGS:
-I$(srctree)/tools/include
and include from there: <linux/kernel.h>

I'll update the Makefile in v2, and remove this definition from here.

> 
>> +
>> +static struct counter_watch simple_watch[] = {
>> +	{
>> +		/* Component data: Count 0 count */
>> +		.component.type = COUNTER_COMPONENT_COUNT,
>> +		.component.scope = COUNTER_SCOPE_COUNT,
>> +		.component.parent = 0,
>> +		/* Event type: Index */
>> +		.event = COUNTER_EVENT_OVERFLOW_UNDERFLOW,
> 
> There's a bit of confusion here. The comment says the event type is
> INDEX, but the structure event type is set for OVERFLOW_UNDERFLOW; also,
> the commit description states that we're monitoring "overflows" which
> implies to me the OVERFLOW event type. So which of the three is it?

Ah yes, It's a mix of bad copy paste and updates. I'll fix it.

> 
>> +		/* Device event channel 0 */
>> +		.channel = 0,
>> +	},
>> +};
>> +
>> +static int find_match_or_number_from_array(char *arg, const char * const str[], int sz, __u8 *val)
>> +{
>> +	unsigned int i;
>> +	char *dummy;
>> +	unsigned long idx;
>> +	int ret;
>> +
>> +	for (i = 0; i < sz; i++) {
>> +		ret = strncmp(arg, str[i], strlen(str[i]));
>> +		if (!ret && strlen(str[i]) == strlen(arg)) {
>> +			*val = i;
>> +			return 0;
>> +		}
> 
> This has several strlen calls so I wonder if it's more wasteful than it
> needs to me. I suppose the compiler would optimize this away, but I
> think there is an alternative solution.
> 
> We're checking for an exact match, so you don't need the string length.
> Instead, you can compare each character, break when characters differ,
> or return 0 when you reached the null byte for both. So something like
> this:
> 
>     for (j = 0; arg[j] == str[i][j]; j++) {
>             /* If we reached the end of the strings */
>             if (arg[j] == '\0') {
>                     *val = i;
>                     return 0;
>             }
>     }
>     /* Strings do not match; continue to the next string */
> 
> We end up with the same number of lines, so I'll leave it up to you
> whether you want to use this solution, or if you consider the existing
> code clearer read.

I'll look forward in the direction you propose. First, we need to
confirm in which form the arguments can be expected. It depends on your
proposal to use a --watch string formatted arguments.

> 
>> +	}
>> +
>> +	/* fallback to number */
> 
> I'm not sure it makes sense to support numbers. Although it's true that
> the component type, component scope, and event type are passed as __u8
> values, users are expected to treat those values are opaque and pass
> them via the respective enum constants. Since we don't guarantee that
> the specific enum constant values will remain consistent between kernel
> versions, I don't think it's a good idea to give to users that sort of
> implication by allowing them to use raw numbers for configuration
> selection.

Ack, I can remove this.

I'm a bit surprised by this statement. I may be wrong... I'd expect a
userland binary to be compatible when updating to a newer kernel: e.g.
user API (ABI?) definitions to be stable (including enum constants) ?

> 
>> +	idx = strtoul(optarg, &dummy, 10);
>> +	if (!errno) {
>> +		if (idx >= sz)
>> +			return -EINVAL;
>> +		*val = idx;
>> +		return 0;
>> +	}
>> +
>> +	return -errno;
>> +}
>> +
>> +static const char * const counter_event_type_name[] = {
>> +	"COUNTER_EVENT_OVERFLOW",
>> +	"COUNTER_EVENT_UNDERFLOW",
>> +	"COUNTER_EVENT_OVERFLOW_UNDERFLOW",
>> +	"COUNTER_EVENT_THRESHOLD",
>> +	"COUNTER_EVENT_INDEX",
>> +	"COUNTER_EVENT_CHANGE_OF_STATE",
>> +	"COUNTER_EVENT_CAPTURE",
>> +};
>> +
>> +static int counter_arg_to_event_type(char *arg, __u8 *event)
>> +{
>> +	return find_match_or_number_from_array(arg, counter_event_type_name,
>> +					       ARRAY_SIZE(counter_event_type_name), event);
>> +}
>> +
>> +static const char * const counter_component_type_name[] = {
>> +	"COUNTER_COMPONENT_NONE",
>> +	"COUNTER_COMPONENT_SIGNAL",
>> +	"COUNTER_COMPONENT_COUNT",
>> +	"COUNTER_COMPONENT_FUNCTION",
>> +	"COUNTER_COMPONENT_SYNAPSE_ACTION",
>> +	"COUNTER_COMPONENT_EXTENSION",
>> +};
>> +
>> +static int counter_arg_to_component_type(char *arg, __u8 *type)
>> +{
>> +	return find_match_or_number_from_array(arg, counter_component_type_name,
>> +					       ARRAY_SIZE(counter_component_type_name), type);
>> +}
>> +
>> +static const char * const counter_scope_name[] = {
>> +	"COUNTER_SCOPE_DEVICE",
>> +	"COUNTER_SCOPE_SIGNAL",
>> +	"COUNTER_SCOPE_COUNT",
>> +};
>> +
>> +static int counter_arg_to_scope(char *arg, __u8 *type)
>> +{
>> +	return find_match_or_number_from_array(arg, counter_scope_name,
>> +					       ARRAY_SIZE(counter_scope_name), type);
>> +}
>> +
>> +static void print_usage(void)
>> +{
>> +	fprintf(stderr, "Usage: counter_watch_events [options]...\n"
>> +		"Test various watch events for given counter device\n"
>> +		"  --channel -c <n>\n"
>> +		"        Set watch.channel\n"
>> +		"  --debug -d\n"
>> +		"        Prints debug information\n"
>> +		"  --event -e <number or counter_event_type string>\n"
>> +		"        Sets watch.event\n"
>> +		"  --help -h\n"
>> +		"        Prints usage\n"
>> +		"  --device-num -n <n>\n"
>> +		"        Set device number (/dev/counter<n>, default to 0)\n"
>> +		"  --id -i <n>\n"
>> +		"        Set watch.component.id\n"
>> +		"  --loop -l <n>\n"
>> +		"        Loop for a number of events (forever if n < 0)\n"
>> +		"  --parent -p <n>\n"
>> +		"        Set watch.component.parent number\n"
>> +		"  --scope -s <number or counter_scope string>\n"
>> +		"        Set watch.component.scope\n"
>> +		"  --type -t <number or counter_component_type string>\n"
>> +		"        Set watch.component.type\n"
>> +		"\n"
>> +		"Example with two watched events:\n\n"
>> +		"counter_watch_events -d \\\n"
>> +		"\t-t COUNTER_COMPONENT_COUNT -s COUNTER_SCOPE_COUNT"
>> +		" -e COUNTER_EVENT_OVERFLOW_UNDERFLOW -i 0 -c 0 \\\n"
>> +		"\t-t COUNTER_COMPONENT_EXTENSION -s COUNTER_SCOPE_COUNT"
>> +		" -e COUNTER_EVENT_CAPTURE -i 7 -c 3\n"
>> +		);
>> +}
> 
> Are you following any particular convention for the usage description? I
> wonder if there is a particular preferred standard for command-line
> interface descriptions. A quick search brought up a few, such as the
> POSIX Utility Conventions[^1] and docopt[^2].
> 
> One improvement I would recommend here is to put the short form of the
> option before the long form and separate them with a command to make it
> clearer (e.g. "-h, --help").
> 
> [^1] https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html
> [^2] http://docopt.org

Thanks for pointing this! So definitely a good pointer, and suggestion
to look at!

I'll try to improve in v2.

> 
>> +
>> +static void print_watch(struct counter_watch *watch, int nwatch)
>> +{
>> +	int i;
>> +
>> +	/* prints the watch array in C-like structure */
>> +	printf("watch[%d] = {\n", nwatch);
>> +	for (i = 0; i < nwatch; i++) {
>> +		printf(" [%d] =\t{\n"
>> +		       "\t\t.component.type = %s\n"
>> +		       "\t\t.component.scope = %s\n"
>> +		       "\t\t.component.parent = %d\n"
>> +		       "\t\t.component.id = %d\n"
>> +		       "\t\t.event = %s\n"
>> +		       "\t\t.channel = %d\n"
>> +		       "\t},\n",
>> +		       i,
>> +		       counter_component_type_name[watch[i].component.type],
>> +		       counter_scope_name[watch[i].component.scope],
>> +		       watch[i].component.parent,
>> +		       watch[i].component.id,
>> +		       counter_event_type_name[watch[i].event],
>> +		       watch[i].channel);
>> +	}
>> +	printf("};\n");
>> +}
>> +
>> +static const struct option longopts[] = {
>> +	{ "channel",		required_argument, 0, 'c' },
>> +	{ "debug",		no_argument,       0, 'd' },
>> +	{ "event",		required_argument, 0, 'e' },
>> +	{ "help",		no_argument,       0, 'h' },
>> +	{ "device-num",		required_argument, 0, 'n' },
>> +	{ "id",			required_argument, 0, 'i' },
>> +	{ "loop",		required_argument, 0, 'l' },
>> +	{ "parent",		required_argument, 0, 'p' },
>> +	{ "scope",		required_argument, 0, 's' },
>> +	{ "type",		required_argument, 0, 't' },
>> +	{ },
>> +};
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int c, fd, i, ret;
>> +	struct counter_event event_data;
>> +	char *device_name = NULL;
>> +	int debug = 0, loop = -1;
>> +	char *dummy;
>> +	int dev_num = 0, nwatch = 0, ncfg[] = {0, 0, 0, 0, 0, 0};
>> +	int num_chan = 0, num_evt = 0, num_id = 0, num_p = 0, num_s = 0, num_t = 0;
>> +	struct counter_watch *watches;
>> +
>> +	/*
>> +	 * 1st pass: count events configurations number to allocate the watch array.
>> +	 * Each watch argument can be repeated several times: each time it gets repeated,
>> +	 * a corresponding watch is allocated (and configured) in 2nd pass.
>> +	 */
> 
> It feels a somewhat prone to error (at least cumbersome) to populate

Yes, this could be error prone. This is also why I added a print of the
gathered arguments when using --debug option.
Perhaps this could be better to always print it (e.g. print_watch()) ?

> each watch via individual arguments for each field. Since a watch always
> has these fields, perhaps instead we could pass some format string that
> represents a watch, and deliminate watches via commas. For example, we
> could have --watch="cco00,ecc73" to represent the two watches in the
> usage example.

I like the idea, to concatenate as a string. With current approach, the
command line quickly becomes very long.

It makes it obvious in your example, that two watches are used, and no
argument is omitted.
On the opposite, each argument isn't very easy to understand compared to
plain text definition.

> 
> Of course, we'd need to define a more robust format string convention
> than in my example to ensure the correct configuration is properly

Indeed, by using a single letter, we could face limitations (ex:
overflow, underflow, overflow_underflow, which letter for the 3rd here?)

If we go this way, probably need to brainstorm a bit.

> communicated. What do you think, would this approach would make things
> simpler, or just more complicated in the end?

I'm not 100% sure if some helpers like getopt() will help here? So, I
guess this could be more complicated. This may also be against the
guideline "options should be preceded by the '-' delimiter character."
in [^1] (Ok, this would rather be the --watch option, fed with watch data.)

Would you have suggestions regarding possible helpers ? Or do you have
in mind some others tools that already adopted such approach ?

> 
>> +	while ((c = getopt_long(argc, argv, "c:de:hn:i:l:p:s:t:", longopts, NULL)) != -1) {
>> +		switch (c) {
>> +		case 'c':
>> +			ncfg[0]++;
>> +			break;
>> +		case 'e':
>> +			ncfg[1]++;
>> +			break;
>> +		case 'i':
>> +			ncfg[2]++;
>> +			break;
>> +		case 'p':
>> +			ncfg[3]++;
>> +			break;
>> +		case 's':
>> +			ncfg[4]++;
>> +			break;
>> +		case 't':
>> +			ncfg[5]++;
>> +			break;
>> +		};
>> +	};
>> +
>> +	for (i = 0; i < ARRAY_SIZE(ncfg); i++)
>> +		if (ncfg[i] > nwatch)
>> +			nwatch = ncfg[i];
>> +
>> +	if (nwatch) {
>> +		watches = calloc(nwatch, sizeof(*watches));
> 
> We need to check if calloc fails, right?

Yes, you're right, will fix this too.

Thanks for reviewing!
Best regards,
Fabrice

> 
> William Breathitt Gray 
